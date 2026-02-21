---@alias PackManTask fun():any

---@class PackManCondition
---@field event? string|string[] Autocommand event(s) to wait for
---@field pattern? string|string[] File pattern(s) to match

---@class PluginHooks
---@field post_install? fun() Executed after fresh install
---@field post_checkout? fun() Executed after update (and fresh install)

---@class PluginSpec
---@field [1]? string The plugin URL or short name
---@field src? string Alternative to [1]
---@field name? string Custom directory name
---@field version? string The branch, tag, or commit hash
---@field hooks? PluginHooks Lifecycle hooks

---@class PackMan
_G.PackMan = {}
local load_queue = {}
local is_processing = false

local TIME_BUDGET_MS = 32
local TIME_BUDGET_NS = TIME_BUDGET_MS * 1000000

local function infer_name_from_src(src)
  if not src then
    return nil
  end
  src = src:gsub('/+$', '')
  local tail = src:match '([^/]+)$'
  if not tail then
    return nil
  end
  return tail:gsub('%.git$', '')
end

local function packadd_if_needed(name, data)
  -- data.active means "already on rtp" for this event
  if data.active then return end
  local ok, err = pcall(vim.cmd.packadd, name)
  if not ok then
    notify(("packadd failed for %s:\n%s"):format(name, err), vim.log.levels.ERROR)
  end
end

---Add a plugin using vim.pack.add.
---@param spec string|PluginSpec
function PackMan.add(spec)
  if type(spec) == 'string' then
    spec = { src = spec }
  elseif spec[1] and not spec.src then
    spec.src = spec[1]
    spec[1] = nil
  end

  -- Ensure we have a name for hook matching (vim.pack also infers this,
  -- but we need it here to compare in the callback).
  spec.name = spec.name or infer_name_from_src(spec.src)
  local name = spec.name

  if spec.hooks and name then
    vim.api.nvim_create_autocmd('PackChanged', {
      callback = function(ev)
        local data = ev.data
        if not data or not data.spec or data.spec.name ~= name then
          return
        end

        -- kind: "install" | "update" | "delete"
        local kind = data.kind

        if kind == 'install' and spec.hooks.post_install then
          vim.schedule(function()
            spec.hooks.post_install(data)
          end)
        elseif (kind == 'install' or kind == 'update') and spec.hooks.post_checkout then
          vim.schedule(function()
            if not ev.active then
              vim.pack.add { spec }
            end
            spec.hooks.post_checkout(data)
          end)
        end
      end,
    })
  end

  vim.pack.add { spec }
end

local function process_queue()
  if #load_queue == 0 then
    is_processing = false
    return
  end

  local start_time = vim.uv.hrtime()

  while #load_queue > 0 do
    local task = table.remove(load_queue, 1)

    local status, err = pcall(task)
    if not status then
      vim.notify('PackMan Error: ' .. tostring(err), vim.log.levels.ERROR)
    end

    local elapsed = vim.uv.hrtime() - start_time
    if elapsed > TIME_BUDGET_NS then
      vim.schedule(process_queue)
      return
    end
  end

  is_processing = false
end

---@param task PackManTask
---@param condition? string|string[]
function PackMan.now(task, condition)
  if condition then
    local opts = type(condition) == 'table' and condition or { pattern = condition }
    local pattern = opts.pattern

    local buf_name = vim.api.nvim_buf_get_name(0)
    if buf_name == '' then
      buf_name = '[No Name]'
    end

    if vim.fn.match(buf_name, vim.fn.glob2regpat(pattern)) == -1 then
      return
    end
  end

  local status, err = pcall(task)
  if not status then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

---@param task PackManTask
---@param condition? string|PackManCondition
function PackMan.later(task, condition)
  if condition then
    local events = type(condition) == 'table' and condition.event or condition
    local opts = type(condition) == 'table' and condition or {}

    vim.api.nvim_create_autocmd(events, {
      pattern = opts.pattern or '*',
      group = vim.api.nvim_create_augroup('PackMan_' .. tostring(task), { clear = true }),
      once = true,
      callback = function()
        local status, err = pcall(task)
        if not status then
          vim.notify(err, vim.log.levels.ERROR)
        end
      end,
    })
    return
  end

  table.insert(load_queue, task)

  if vim.v.vim_did_enter == 1 and not is_processing then
    is_processing = true
    vim.schedule(process_queue)
  end
end

PackMan.now_if_args = vim.fn.argc(-1) > 0 and PackMan.now or PackMan.later

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if not is_processing and #load_queue > 0 then
      is_processing = true
      vim.defer_fn(process_queue, 10)
    end
  end,
})

local function get_plugin_names()
  -- vim.pack.get() returns a table of installed plugins in the new native system
  local plugins = vim.pack.get()
  local names = {}
  for name, _ in pairs(plugins) do
    table.insert(names, name)
  end
  table.sort(names)
  return names
end

vim.api.nvim_create_user_command('PackMan', function(opts)
  local subcommand = opts.fargs[1]
  local args = { unpack(opts.fargs, 2) }

  if subcommand == 'update' then
    if #args == 0 then
      vim.notify('PackMan: Updating all plugins...', vim.log.levels.INFO)
      vim.pack.update()
    else
      vim.notify('PackMan: Updating ' .. table.concat(args, ', '), vim.log.levels.INFO)
      vim.pack.update(args)
    end
  elseif subcommand == 'add' then
    if #args == 0 then
      vim.notify('Usage: :PackMan add <url_or_name>', vim.log.levels.ERROR)
      return
    end

    local spec = args[1]
    PackMan.add(spec)
    vim.notify('PackMan: Added ' .. spec, vim.log.levels.INFO)
  else
    vim.notify('Unknown subcommand: ' .. subcommand, vim.log.levels.ERROR)
  end
end, {
  nargs = '+', -- Requires at least one argument (the subcommand)
  desc = 'PackMan interface: update [plugins...], add <spec>',
  complete = function(arg_lead, cmd_line, cursor_pos)
    local split_args = vim.split(cmd_line, '%s+')

    if #split_args == 2 then
      local subcommands = { 'update', 'add' }
      return vim.tbl_filter(function(val)
        return vim.startswith(val, arg_lead)
      end, subcommands)
    end

    if split_args[2] == 'update' then
      return vim.tbl_filter(function(val)
        return vim.startswith(val, arg_lead)
      end, get_plugin_names())
    end
  end,
})
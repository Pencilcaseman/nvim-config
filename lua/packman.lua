---@mod packman
---@brief PackMan: vim.pack helper with dependency expansion, hooks, clean, and two-stage execution.

---@alias PackManTask fun():any

---@class PackManCondition
---@field event? string|string[] Autocommand event(s) to wait for
---@field pattern? string|string[] File pattern(s) to match (glob)

---@class PackManHookData
---@field path string Absolute plugin directory path.
---@field src string|nil Plugin source URL.
---@field name string Plugin directory name.
---@field kind '"install"'|'"update"'|'"delete"'
---@field active boolean Whether plugin is active in current session at event time.
---@field spec table Resolved spec from `vim.pack` event.

---@class PackManHooks
---@field pre_install? fun(data: PackManHookData)
---@field post_install? fun(data: PackManHookData)
---@field pre_checkout? fun(data: PackManHookData)
---@field post_checkout? fun(data: PackManHookData)

---@class PackManSpec
---@field [1]? string Convenience field; becomes `src` if `src` is absent.
---@field src? string Plugin URL or short `user/repo`.
---@field name? string Directory name; inferred from `src` if omitted.
---@field version? any Branch/tag/commit forwarded to `vim.pack`.
---@field depends? (string|PackManSpec)[] Dependency specs added before this plugin.
---@field hooks? PackManHooks Lifecycle hooks.
---@field data? any Extra data forwarded to `vim.pack`.

---@class PackManConfig
---@field silent? boolean Suppress INFO messages.
---@field load_for_post_hooks? boolean `packadd` plugin before running post hooks if it isn't active.
---@field confirm_clean? boolean Confirmation buffer for `clean()` unless forced.
---@field time_budget_ms? integer Time budget per drain tick for later queue.
---@field reset? boolean If true, clears session and hook registry.

_G.PackMan = _G.PackMan or {}
local PackMan = _G.PackMan

local S = PackMan._state
  or {
    session = {}, -- expanded specs added this session (flattened)
    hooks_by_name = {}, -- name -> hooks table
    hooks_ready = false,

    later_queue = {},
    is_processing = false,

    exec_errors = {},
    cmd_ready = false,
  }
PackMan._state = S

PackMan.config = PackMan.config or {
  silent = false,
  load_for_post_hooks = true,
  confirm_clean = true,
  time_budget_ms = 32,
}

local function notify(msg, level)
  level = level or vim.log.levels.INFO
  if PackMan.config.silent and level < vim.log.levels.WARN then
    return
  end
  vim.schedule(function()
    vim.notify(('PackMan: %s'):format(msg), level)
  end)
end

local function infer_name_from_src(src)
  if type(src) ~= 'string' or src == '' then
    return nil
  end
  src = src:gsub('/+$', '')
  local tail = src:match '([^/]+)$'
  if not tail then
    return nil
  end
  return tail:gsub('%.git$', '')
end

local function normalize_src(src)
  if type(src) ~= 'string' then
    return src
  end
  -- GitHub short form: user/repo
  if src:match '^[%w-]+/[%w-_.]+$' then
    return 'https://github.com/' .. src
  end
  return src
end

local function call_hook_safely(fn, hook_name, plugin_name, data)
  local ok, err = xpcall(function()
    fn(data)
  end, debug.traceback)
  if not ok then
    notify(("Error in '%s' hook for '%s':\n%s"):format(hook_name, plugin_name, err), vim.log.levels.ERROR)
  end
end

local function safe_packadd(name)
  local ok, err = pcall(vim.cmd.packadd, name)
  if not ok then
    notify(('packadd failed for %s:\n%s'):format(name, err), vim.log.levels.ERROR)
  end
end

local function normalize_spec(spec)
  if type(spec) == 'string' then
    spec = { src = spec }
  end
  if type(spec) ~= 'table' then
    error('PackMan: spec must be a string or table', 3)
  end

  if spec[1] and spec.src == nil then
    spec.src = spec[1]
    spec[1] = nil
  end

  if spec.src == nil then
    error("PackMan: spec requires 'src' (or [1])", 3)
  end

  spec.src = normalize_src(spec.src)
  spec.name = spec.name or infer_name_from_src(spec.src)

  if type(spec.name) ~= 'string' or spec.name == '' then
    error('PackMan: could not infer plugin name; set spec.name', 3)
  end

  if spec.depends == nil then
    spec.depends = {}
  end
  if not vim.islist(spec.depends) then
    error('PackMan: spec.depends must be an array', 3)
  end

  if spec.hooks == nil then
    spec.hooks = {}
  end
  if type(spec.hooks) ~= 'table' then
    error('PackMan: spec.hooks must be a table', 3)
  end

  return spec
end

local function expand_spec(out, spec, seen)
  seen = seen or {}
  spec = normalize_spec(spec)

  if seen[spec.name] then
    return
  end
  seen[spec.name] = true

  for _, dep in ipairs(spec.depends) do
    expand_spec(out, dep, seen)
  end

  out[#out + 1] = spec
end

local function ensure_hook_autocmds()
  if S.hooks_ready then
    return
  end
  S.hooks_ready = true

  local group = vim.api.nvim_create_augroup('PackManHooks', { clear = true })

  local function run_post(name, data, hooks, hook_name)
    vim.schedule(function()
      if PackMan.config.load_for_post_hooks then
        safe_packadd(name)
      end
      local fn = hooks[hook_name]
      if vim.is_callable(fn) then
        call_hook_safely(fn, hook_name, name, data)
      end
    end)
  end

  local function dispatch(stage, ev)
    local d = ev.data
    if type(d) ~= 'table' or type(d.spec) ~= 'table' then
      return
    end

    local name = d.spec.name
    if type(name) ~= 'string' then
      return
    end

    local hooks = S.hooks_by_name[name]
    if type(hooks) ~= 'table' then
      return
    end

    ---@type PackManHookData
    local data = {
      path = d.path,
      src = d.spec.src,
      name = name,
      kind = d.kind,
      active = d.active,
      spec = d.spec,
    }

    if stage == 'pre' then
      if d.kind == 'install' and vim.is_callable(hooks.pre_install) then
        call_hook_safely(hooks.pre_install, 'pre_install', name, data)
      elseif d.kind == 'update' and vim.is_callable(hooks.pre_checkout) then
        call_hook_safely(hooks.pre_checkout, 'pre_checkout', name, data)
      end
      return
    end

    if d.kind == 'install' and vim.is_callable(hooks.post_install) then
      run_post(name, data, hooks, 'post_install')
    end

    if (d.kind == 'install' or d.kind == 'update') and vim.is_callable(hooks.post_checkout) then
      run_post(name, data, hooks, 'post_checkout')
    end
  end

  vim.api.nvim_create_autocmd('PackChangedPre', {
    group = group,
    callback = function(ev)
      dispatch('pre', ev)
    end,
    desc = 'PackMan: dispatch pre hooks',
  })

  vim.api.nvim_create_autocmd('PackChanged', {
    group = group,
    callback = function(ev)
      dispatch('post', ev)
    end,
    desc = 'PackMan: dispatch post hooks',
  })
end

local function init()
  ensure_hook_autocmds()
end

-- --------- Two-stage execution (original behavior + time budget) ----------

local function drain_later_queue()
  if #S.later_queue == 0 then
    S.is_processing = false
    return
  end

  local start = vim.uv.hrtime()
  local budget_ns = (PackMan.config.time_budget_ms or 32) * 1e6

  while #S.later_queue > 0 do
    local task = table.remove(S.later_queue, 1)

    local ok, err = pcall(task)
    if not ok then
      S.exec_errors[#S.exec_errors + 1] = err
    end

    if (vim.uv.hrtime() - start) > budget_ns then
      vim.schedule(drain_later_queue)
      return
    end
  end

  S.is_processing = false

  if #S.exec_errors > 0 then
    local msg = table.concat(S.exec_errors, '\n\n')
    S.exec_errors = {}
    notify('Errors during deferred execution:\n\n' .. msg, vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('PackManVimEnter', { clear = true }),
  callback = function()
    if not S.is_processing and #S.later_queue > 0 then
      S.is_processing = true
      vim.defer_fn(drain_later_queue, 10)
    end
  end,
})

-- --------- Public API ----------

function PackMan.setup(config)
  config = config or {}
  PackMan.config = vim.tbl_deep_extend('force', PackMan.config, config)
  init()
  if config.reset then
    S.session = {}
    S.hooks_by_name = {}
  end
end

---@param spec string|PackManSpec
---@param opts? table forwarded to vim.pack.add
function PackMan.add(spec, opts)
  opts = opts or {}

  local expanded = {}
  expand_spec(expanded, spec)

  -- Register session + hooks by name
  for _, s in ipairs(expanded) do
    S.session[#S.session + 1] = vim.deepcopy(s)
    if type(s.hooks) == 'table' and next(s.hooks) ~= nil then
      S.hooks_by_name[s.name] = vim.tbl_deep_extend('force', S.hooks_by_name[s.name] or {}, s.hooks)
    end
  end

  -- Forward only vim.pack relevant fields
  local pack_specs = {}
  for _, s in ipairs(expanded) do
    pack_specs[#pack_specs + 1] = {
      src = s.src,
      name = s.name,
      version = s.version,
      data = s.data,
    }
  end

  vim.pack.add(pack_specs, opts)
end

function PackMan.update(names, opts)
  vim.pack.update(names, opts)
end

-- Original-style "now": optional glob condition against current buffer name.
---@param task PackManTask
function PackMan.now(task)
  local ok, err = pcall(task)
  if not ok then
    notify(tostring(err), vim.log.levels.ERROR)
  end
end

-- Original-style "later": if condition -> autocmd once, else enqueue with time budget drain.
---@param task PackManTask
---@param condition? string|PackManCondition
function PackMan.later(task, condition)
  if condition then
    local events = condition
    local opts = {}
    if type(condition) == 'table' then
      events = condition.event or 'VimEnter'
      opts = condition
    end

    vim.api.nvim_create_autocmd(events, {
      pattern = opts.pattern or '*',
      group = vim.api.nvim_create_augroup('PackManLater_' .. tostring(task), { clear = true }),
      once = true,
      callback = function()
        PackMan.now(task) -- capture errors via now()
      end,
      desc = 'PackMan.later(condition)',
    })
    return
  end

  S.later_queue[#S.later_queue + 1] = task

  if vim.v.vim_did_enter == 1 and not S.is_processing then
    S.is_processing = true
    vim.schedule(drain_later_queue)
  end
end

PackMan.now_if_args = (vim.fn.argc(-1) > 0) and PackMan.now or PackMan.later

-- ---------- Session + clean helpers ----------

function PackMan.get_session()
  -- Merge by name, preserving accumulated depends lists.
  local res, by_name = {}, {}
  for _, s in ipairs(S.session) do
    local idx = by_name[s.name] or (#res + 1)
    local cur = res[idx] or { depends = {} }

    local depends = vim.deepcopy(cur.depends or {})
    vim.list_extend(depends, s.depends or {})

    res[idx] = vim.tbl_deep_extend('force', cur, s)
    res[idx].depends = depends
    by_name[s.name] = idx
  end
  S.session = res
  return vim.deepcopy(res)
end

local function iter_pack_get()
  local got = vim.pack.get()
  if vim.islist(got) then
    local i = 0
    return function()
      i = i + 1
      return got[i]
    end
  end
  -- map-like: name -> plugin
  local k
  return function()
    k = next(got, k)
    if k == nil then
      return nil
    end
    return got[k]
  end
end

function PackMan.clean(opts)
  opts = opts or {}
  local force = opts.force == true

  local keep = {}
  for _, s in ipairs(PackMan.get_session()) do
    keep[s.name] = true
  end

  local to_delete = {}
  for plug in iter_pack_get() do
    local name = plug and plug.spec and plug.spec.name
    if type(name) == 'string' and not keep[name] then
      to_delete[#to_delete + 1] = name
    end
  end
  table.sort(to_delete)

  if #to_delete == 0 then
    notify 'Nothing to clean'
    return
  end

  if force or not PackMan.config.confirm_clean then
    vim.pack.del(to_delete)
    return
  end

  local lines = {
    'Confirm clean.',
    '',
    "Lines '- <name>' will be deleted. Remove a line to keep it.",
    'Write the buffer to apply. Close to cancel.',
    '',
  }
  for _, n in ipairs(to_delete) do
    lines[#lines + 1] = ('- %s'):format(n)
  end

  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_name(buf, ('packman://%d/confirm-clean'):format(buf))
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.cmd('tab sbuffer ' .. buf)

  vim.bo[buf].buftype = 'acwrite'
  vim.bo[buf].filetype = 'packman-confirm'
  vim.bo[buf].modified = false

  vim.api.nvim_create_autocmd('BufWriteCmd', {
    buffer = buf,
    nested = true,
    callback = function()
      local chosen = {}
      for _, l in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
        local n = l:match '^%- (.+)$'
        if n then
          chosen[#chosen + 1] = n
        end
      end
      if #chosen == 0 then
        notify 'Nothing to delete'
      else
        vim.pack.del(chosen)
      end
      pcall(vim.api.nvim_buf_delete, buf, { force = true })
      pcall(vim.cmd, 'tabclose')
    end,
  })
end

-- ---------- Command :PackMan (original interface + clean) ----------

local function get_plugin_names()
  local names = {}
  for plug in iter_pack_get() do
    local name = plug and plug.spec and plug.spec.name
    if type(name) == 'string' then
      names[#names + 1] = name
    end
  end
  table.sort(names)
  return names
end

local function ensure_user_command()
  if S.cmd_ready then
    return
  end
  S.cmd_ready = true

  vim.api.nvim_create_user_command('PackMan', function(opts)
    local sub = opts.fargs[1]
    local args = { unpack(opts.fargs, 2) }

    if sub == 'update' then
      if #args == 0 then
        notify 'Updating all plugins...'
        vim.pack.update()
      else
        notify('Updating ' .. table.concat(args, ', '))
        vim.pack.update(args)
      end
      return
    end

    if sub == 'add' then
      if #args == 0 then
        notify('Usage: :PackMan add <url_or_name>', vim.log.levels.ERROR)
        return
      end
      local s = args[1]
      PackMan.add(s)
      notify('Added ' .. s)
      return
    end

    if sub == 'clean' then
      local force = false
      for _, a in ipairs(args) do
        if a == '--force' or a == '-f' then
          force = true
        end
      end
      PackMan.clean { force = force }
      return
    end

    notify('Unknown subcommand: ' .. tostring(sub), vim.log.levels.ERROR)
  end, {
    nargs = '+',
    desc = 'PackMan: update [plugins...], add <spec>, clean [--force]',
    complete = function(arg_lead, cmd_line, _)
      local split_args = vim.split(cmd_line, '%s+')
      if #split_args == 2 then
        local subs = { 'update', 'add', 'clean' }
        return vim.tbl_filter(function(v)
          return vim.startswith(v, arg_lead)
        end, subs)
      end

      local sub = split_args[2]
      if sub == 'update' then
        return vim.tbl_filter(function(v)
          return vim.startswith(v, arg_lead)
        end, get_plugin_names())
      end

      if sub == 'clean' then
        local flags = { '--force', '-f' }
        return vim.tbl_filter(function(v)
          return vim.startswith(v, arg_lead)
        end, flags)
      end
    end,
  })
end

ensure_user_command()
init()

return PackMan

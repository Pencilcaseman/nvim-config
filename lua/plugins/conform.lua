local add, later = MiniDeps.add, MiniDeps.later
local now_if_args = _G.Config.now_if_args

local disable_filetypes = {
  -- c = true,
  -- cpp = true,
}

local disabled_filepaths = {
  -- vim.fs.normalize '/my/path',
}

local disable_by_filetype = function(bufnr)
  if disable_filetypes[vim.bo[bufnr].filetype] then
    return true
  end
  return false
end

local ensure_trailing_sep = function(dir)
  if dir == '' then
    return ''
  end

  local sep = package.config:sub(1, 1)
  if dir:sub(-1) ~= sep then
    return dir .. sep
  end

  return dir
end

local disable_by_filepath = function(bufnr)
  local filepath = vim.api.nvim_buf_get_name(bufnr)

  -- If the buffer doesn't have a file path (e.g., unnamed buffer), proceed as normal
  if filepath == '' then
    return false
  end

  -- Normalize the file path and get the directory
  local normalized_filepath = vim.fs.normalize(filepath)
  local filedir = vim.fn.fnamemodify(normalized_filepath, ':h') -- ':h' gets the head/directory

  filedir = ensure_trailing_sep(filedir)

  -- Check if the file's directory is within any of the disabled directories
  for _, disabled_dir in ipairs(disabled_filepaths) do
    disabled_dir = ensure_trailing_sep(disabled_dir)

    if string.find(filedir, disabled_dir, 1, true) == 1 then
      return true
    end
  end

  return false
end

later(function()
  add 'stevearc/conform.nvim'

  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if vim.g.conform_format_override or vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      local lsp_format_opt

      if disable_by_filepath(bufnr) or disable_by_filetype(bufnr) then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end

      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,

    formatters_by_ft = {
      lua = { 'stylua' },
      typst = { 'typstyle', lsp_format = 'prefer' },
      cmake = { 'gersemi' },
    },
  }

  vim.keymap.set('n', '<leader>F', function()
    -- Format regardless of the autoformatting option
    vim.g.conform_format_override = true
    require('conform').format { async = true, lsp_format = 'fallback' }
    vim.g.conform_format_override = false
  end, {
    desc = '[F]ormat Buffer',
  })

  vim.api.nvim_create_user_command('FormatDisable', function(args)
    if args.bang then
      -- :FormatDisable! disables autoformat for this buffer only
      vim.b.disable_autoformat = true
    else
      -- :FormatDisable disables autoformat globally
      vim.g.disable_autoformat = true
    end
  end, {
    desc = 'Disable autoformat-on-save',
    bang = true, -- allows the bang variant
  })

  vim.api.nvim_create_user_command('FormatEnable', function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
  end, {
    desc = 'Re-enable autoformat-on-save',
  })
end)

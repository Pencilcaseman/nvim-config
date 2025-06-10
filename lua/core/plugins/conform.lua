local disable_filetypes = {
  -- c = true,
  -- cpp = true,
}

local disabled_filepaths = {
  vim.fs.normalize '/Users/tobydavis/Library/CloudStorage/Dropbox/University/Modules/ArtificialIntelligence/Coursework/AISearch/templates',
  vim.fs.normalize '/Users/tobydavis/Library/CloudStorage/Dropbox/University/Modules/ArtificialIntelligence/Coursework/AISearch/cltz62',
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

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
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
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}

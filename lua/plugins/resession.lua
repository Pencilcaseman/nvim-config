local now, add = MiniDeps.now, MiniDeps.add

now(function()
  add 'stevearc/resession.nvim'

  if vim.fn.argc(-1) > 0 then
    return
  end

  local resession = require 'resession'
  resession.setup {}

  vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
      local has_open_file = false
      for buf = 1, vim.fn.bufnr '$' do
        if vim.fn.buflisted(buf) == 1 then
          has_open_file = true
          break
        end
      end

      if vim.fn.argc(-1) == 0 and has_open_file then
        resession.save(vim.fn.getcwd(), { dir = 'dirsession', notify = false })
      end
    end,
  })
end)

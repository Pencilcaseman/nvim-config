-- LSP rename
vim.keymap.set('n', '<leader>cr', function()
  vim.lsp.buf.rename()
end, { desc = '[C]ode [R]ename' })

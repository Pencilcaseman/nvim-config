local add, now = MiniDeps.add, MiniDeps.now

now(function()
  add 'ellisonleao/gruvbox.nvim'

  vim.o.background = 'dark'
  vim.cmd [[colorscheme gruvbox]]
end)

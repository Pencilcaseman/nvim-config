local add, now = PackMan.add, PackMan.now

now(function()
  add 'https://github.com/ellisonleao/gruvbox.nvim'

  vim.o.background = 'dark'
  vim.cmd [[colorscheme gruvbox]]
end)

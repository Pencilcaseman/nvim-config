local later, add = MiniDeps.later, MiniDeps.add

later(function()
  add 'lukas-reineke/indent-blankline.nvim'
  require('ibl').setup {}
end)

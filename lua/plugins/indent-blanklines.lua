local add, later = PackMan.add, PackMan.later

later(function()
  add 'https://github.com/lukas-reineke/indent-blankline.nvim'
  require('ibl').setup {}
end)

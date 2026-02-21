local add, later = PackMan.add, PackMan.later

later(function()
  add 'https://github.com/SmiteshP/nvim-navic'
end)

later(function()
  add 'https://github.com/utilyre/barbecue.nvim'
  require('barbecue').setup {}
end)

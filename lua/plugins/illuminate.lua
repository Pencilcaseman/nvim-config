local add, later = PackMan.add, PackMan.later

later(function()
  add 'https://github.com/RRethy/vim-illuminate'

  require('illuminate').configure {
    providers = {
      'lsp',
      'treesitter',
      'regex',
    },
    delay = 0,
  }
end)

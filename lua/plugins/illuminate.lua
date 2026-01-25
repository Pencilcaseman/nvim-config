local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add 'RRethy/vim-illuminate'

  require('illuminate').configure {
    providers = {
      'lsp',
      'treesitter',
      'regex',
    },
    delay = 0,
  }
end)

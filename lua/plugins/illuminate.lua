return {
  'RRethy/vim-illuminate',
  event = 'LazyFile',
  opts = {
    providers = {
      'lsp',
      'treesitter',
      -- 'regex',
    },
    delay = 200,
  },

  config = function(_, opts)
    require('illuminate').configure(opts)
  end,
}

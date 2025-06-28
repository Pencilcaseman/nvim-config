return {
  'lewis6991/gitsigns.nvim',

  event = 'LazyFile',

  opts = {},
  config = function(_, opts)
    require('gitsigns').setup(opts)
  end,
}

return {
  'andrewferrier/wrapping.nvim',
  opts = {},
  config = function(_, opts)
    require('wrapping').setup(opts)
  end,
}

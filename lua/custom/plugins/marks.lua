return {
  'chentoast/marks.nvim',
  event = 'VeryLazy',
  opts = {
    default_mapping = true,
  },
  config = function(_, opts)
    require('marks').setup(opts)
  end,
}

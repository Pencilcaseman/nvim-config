return {
  'Pencilcaseman/marks.nvim',
  event = 'VeryLazy',
  enabled = false,
  opts = {
    default_mapping = true,
  },
  config = function(_, opts)
    require('marks').setup(opts)
  end,
}

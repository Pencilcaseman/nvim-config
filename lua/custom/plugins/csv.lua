return {
  'hat0uma/csvview.nvim',
  opts = {},
  config = function(_, opts)
    require('csvview').setup(opts)
  end,
}

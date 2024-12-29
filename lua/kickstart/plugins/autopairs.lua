return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    check_ts = true,
    map_bs = true,
    enable_afterquote = true,
  },
  config = function(_, opts)
    require('nvim-autopairs').setup(opts)
  end,
}

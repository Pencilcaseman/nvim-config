return {
  'navarasu/onedark.nvim',
  opts = {
    style = 'deep',
  },
  config = function(_, opts)
    require('onedark').setup(opts)
    require('onedark').load()
  end,
}

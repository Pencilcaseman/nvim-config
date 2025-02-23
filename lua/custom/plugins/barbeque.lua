local utils = require 'utils'

-- Not a required plugin
if utils.is_minimal() then
  return {}
end

return {
  'utilyre/barbecue.nvim',
  name = 'barbecue',
  version = '*',
  event = 'VeryLazy',
  dependencies = {
    'SmiteshP/nvim-navic',
    -- 'nvim-tree/nvim-web-devicons',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  opts = {
    theme = 'tokyonight',
  },
}

local utils = require 'utils'

-- Not a required plugin
if utils.is_minimal() then
  return {}
end

return {
  'utilyre/barbecue.nvim',
  name = 'barbecue',
  version = '*',
  event = 'LazyFile',
  dependencies = {
    'SmiteshP/nvim-navic',
  },
  opts = {
    theme = 'tokyonight',
  },
}

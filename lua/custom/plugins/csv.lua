local utils = require 'utils'

-- Not a required plugin
if utils.is_minimal() then
  return {}
end

return {
  'hat0uma/csvview.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('csvview').setup(opts)
  end,
}

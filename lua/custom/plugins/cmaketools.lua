local utils = require 'utils'

-- Not a required plugin
if utils.is_minimal() then
  return {}
end

return {
  'Civitasv/cmake-tools.nvim',
  dependencies = {
    'stevearc/overseer.nvim',
    'nvim-lua/plenary.nvim',
  },
  opts = {},
}

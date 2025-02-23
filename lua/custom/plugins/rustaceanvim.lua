local utils = require 'utils'

-- Just ignore Rusteacnvim if we are in a minimal environment?
if utils.is_minimal() then
  return {}
end

return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false, -- This plugin is already lazy
}

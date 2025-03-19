local utils = require 'utils'

-- Not a required plugin
if utils.is_minimal() then
  return {}
end

return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = 'markdown', -- Loads when a markdown file is opened
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
}

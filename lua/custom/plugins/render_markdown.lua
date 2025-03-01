local utils = require 'utils'

-- Not a required plugin
if utils.is_minimal() then
  return {}
end

return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = 'markdown', -- Loads when a markdown file is opened
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
}

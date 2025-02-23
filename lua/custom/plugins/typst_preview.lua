local utils = require 'utils'

-- Not a required plugin
if utils.is_minimal() then
  return {}
end

return {
  'chomosuke/typst-preview.nvim',
  cmd = 'TypstPreview',
  build = function()
    require('typst-preview').update()
  end,
}

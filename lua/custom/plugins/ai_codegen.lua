local utils = require 'utils'

-- Not a required plugin
if utils.is_minimal() then
  return {}
end

return {
  'supermaven-inc/supermaven-nvim',
  -- commit = '074a83a74ad8a7b6f605df83e2583775aaeb4cfc',
  event = 'VeryLazy',
  opts = {
    keymaps = {
      -- Accept completions on SHIFT+TAB
      accept_suggestion = '<S-TAB>',
    },
  },
  config = function(_, opts)
    require('supermaven-nvim').setup(opts)
  end,
}

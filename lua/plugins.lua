local add, later = MiniDeps.add, MiniDeps.later
local now_if_args = _G.Config.now_if_args

later(function()
  add 'windwp/nvim-autopairs'
  require('nvim-autopairs').setup {}
end)

require 'plugins.barbar'
require 'plugins.barbeque'
require 'plugins.conform'

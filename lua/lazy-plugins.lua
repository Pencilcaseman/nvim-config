-- [[ Configure and install plugins ]]

local utils = require 'utils'

-- Minimal plugin set
local plugins = {
  require 'kickstart/plugins/which-key',
  require 'kickstart/plugins/telescope',
  -- require 'kickstart/plugins/cmp',
  require 'kickstart/plugins/tokyonight',
  require 'kickstart/plugins/mini',
  require 'kickstart/plugins/treesitter',

  require 'kickstart/plugins/indent_line',
  require 'kickstart/plugins/lint',
  require 'kickstart/plugins/autopairs',
  -- require 'kickstart/plugins/neo-tree',
}

-- Other plugins useful for a full configuration
local other_plugins = {
  require 'kickstart/plugins/gitsigns',
  require 'kickstart/plugins/lspconfig',
  require 'kickstart.plugins.conform',
  require 'kickstart/plugins/debug',
}

if not utils.is_minimal() then
  table.insert(plugins, other_plugins)
end

require('lazy').setup({
  plugins,
  { import = 'custom.plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et

-- [[ Configure and install plugins ]]

local plugins = {
  require 'kickstart/plugins/which-key',
  require 'kickstart/plugins/tokyonight',
  require 'kickstart/plugins/mini',
  require 'kickstart/plugins/treesitter',
  require 'kickstart/plugins/lint',
  require 'kickstart/plugins/gitsigns',
  require 'kickstart/plugins/lspconfig',
  require 'kickstart.plugins.conform',
  require 'kickstart/plugins/debug',
}

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

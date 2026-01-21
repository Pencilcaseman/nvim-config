local plugins = {
  require 'core/plugins/which-key',
  require 'core/plugins/mini',
  require 'core/plugins/treesitter',
  require 'core/plugins/gitsigns',
  require 'core/plugins/lspconfig',
  require 'core/plugins/conform',
  require 'core/plugins/debug',
}

require('lazy').setup({
  plugins,
  { import = 'plugins' },
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

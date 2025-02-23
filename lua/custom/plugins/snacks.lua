return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,

  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },

    dashboard = {
      enabled = true,
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        {
          pane = 2,
          icon = ' ',
          title = 'Git Status',
          section = 'terminal',
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = 'git status --short --branch --renames',
          height = 10,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = 'startup' },
      },
    },

    explorer = { enabled = true },

    indent = {
      enabled = true,
      hl = 'SnacksIndent',
      animate = {
        enabled = false,
      },
    },

    input = { enabled = true },

    picker = { enabled = true },

    profiler = { enabled = true },

    notifier = { enabled = true },

    quickfile = { enabled = true },

    scope = { enabled = true },

    statuscolumn = { enabled = true },

    words = { enabled = true },
  },

  config = function(_, opts)
    require('snacks').setup(opts)
  end,

  keys = {
    -- Top Pickers & Explorer
    {
      '<leader>e',
      function()
        Snacks.explorer.open()
      end,
      desc = 'File [E]xplorer',
    },

    {
      '<leader>E',
      function()
        Snacks.explorer.reveal()
      end,
      desc = 'File [E]xplorer',
    },

    -- {
    --   '<leader>,',
    --   function()
    --     Snacks.picker.buffers()
    --   end,
    --   desc = 'Buffers',
    -- },
  },
}

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,

  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },

    dashboard = {
      enabled = true,

      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          {
            icon = ' ',
            key = 's',
            desc = 'Restore Session',
            action = function()
              require('resession').load(vim.fn.getcwd(), {
                dir = 'dirsession',
                silence_errors = true,
              })
            end,
          },
          { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },

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

    picker = { enabled = true },

    profiler = { enabled = true },

    notifier = { enabled = true },

    quickfile = { enabled = true },
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
  },
}

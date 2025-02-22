return {
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',

    keys = {
      {
        '<leader>ff',
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at the current file',
      },
      {
        -- Open in the current working directory
        '<leader>fs',
        '<cmd>Yazi cwd<cr>',
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        '<leader>fr',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume the last yazi session',
      },
    },

    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },

  -- {
  --   'nvim-neo-tree/neo-tree.nvim',
  --   event = 'VeryLazy',
  --   version = '*',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-tree/nvim-web-devicons',
  --     'MunifTanjim/nui.nvim',
  --     '3rd/image.nvim',
  --   },
  --   cmd = 'Neotree',
  --   keys = {
  --     { '<leader>e', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
  --     { '<leader>E', ':Neotree reveal<CR>', desc = 'NeoTree toggle', silent = true },
  --   },
  --   opts = {
  --     filesystem = {
  --       window = {
  --         mappings = {
  --           ['\\'] = 'close_window',
  --         },
  --       },
  --     },
  --   },
  -- },
}

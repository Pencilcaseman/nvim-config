local utils = require 'utils'

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  opts = function()
    -- local resession = require 'resession'

    return {
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          -- {
          --   desc = ' Sessions',
          --   group = 'DiagnosticHint',
          --   action = function()
          --     local resession = require 'resession'
          --     resession.load(vim.fn.getcwd(), { dir = 'dirsession', notify = true })
          --   end,
          --   key = 's',
          -- },
          unpack(utils.is_minimal() and {
            -- Minimal config item
            desc = 'Minimal Config!',
            group = 'DiagnosticHint',
            action = function()
              vim.notify 'Sessions are not available in a minimal configuration'
            end,
            key = 's',
          } or {
            desc = ' Sessions',
            group = 'DiagnosticHint',
            action = function()
              local resession = require 'resession'
              resession.load(vim.fn.getcwd(), { dir = 'dirsession', notify = true })
            end,
            key = 's',
          }),
          {
            desc = ' Mason',
            group = 'Number',
            action = 'Mason',
            key = 'm',
          },
        },
        footer = 'Stupid Fucker.',
      },
    }
  end,
  config = function(_, opts)
    require('dashboard').setup(opts)
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}

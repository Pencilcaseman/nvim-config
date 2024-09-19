-- return {
--   { -- Add indentation guides even on blank lines
--     'lukas-reineke/indent-blankline.nvim',
--     -- Enable `lukas-reineke/indent-blankline.nvim`
--     -- See `:help ibl`
--     main = 'ibl',
--     opts = {
--       -- highlight = {
--       --   'RainbowRed',
--       --   'RainbowYellow',
--       --   'RainbowBlue',
--       --   'RainbowOrange',
--       --   'RainbowGreen',
--       --   'RainbowViolet',
--       --   'RainbowCyan',
--       -- },
--     },
--     --   config = function()
--     --     local highlight = {
--     --       'RainbowRed',
--     --       'RainbowYellow',
--     --       'RainbowBlue',
--     --       'RainbowOrange',
--     --       'RainbowGreen',
--     --       'RainbowViolet',
--     --       'RainbowCyan',
--     --     }
--     --
--     --     local hooks = require 'ibl.hooks'
--     --
--     --     -- create the highlight groups in the highlight setup hook, so they are reset
--     --     -- every time the colorscheme changes
--     --     hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
--     --       vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
--     --       vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
--     --       vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
--     --       vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
--     --       vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
--     --       vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
--     --       vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
--     --     end)
--     --
--     --     require('ibl').setup { indent = { highlight = highlight } }
--     --   end,
--   },
-- }

return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = 'VeryLazy',
  opts = function()
    return {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,

        highlight = {
          'IblScope',
        },

        -- char = '¦',
        char = '╏',
        -- char = '┇',
        -- char = '┋',
        -- char = '│',
        -- char = '║',
      },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
      },
    }
  end,

  config = function(_, opts)
    require('ibl').setup(opts)
    vim.cmd 'IBLEnableScope'
  end,
}

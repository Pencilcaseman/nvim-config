return {
  'saghen/blink.cmp',

  cond = function()
    if vim.g.vscode then
      return false
    end

    return true
  end,

  dependencies = {
    'xzbdmw/colorful-menu.nvim',
    'rafamadriz/friendly-snippets',
  },

  event = 'InsertEnter',
  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'super-tab' },

    -- signature = { window = { border = 'single' } },

    appearance = {
      nerd_font_variant = 'normal',
    },

    cmdline = {
      enabled = true,
      completion = {
        menu = {
          auto_show = true,
        },
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    completion = {
      trigger = {
        show_on_trigger_character = true,
      },

      menu = {
        -- border = 'single',
        scrollbar = false,

        draw = {
          columns = { { 'kind_icon' }, { 'label', gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
              end,
            },
          },
        },
      },

      documentation = {
        -- border = 'single',
        auto_show = true,
        auto_show_delay_ms = 200,
      },

      ghost_text = {
        enabled = true,
      },
    },

    -- Experimental
    -- signature = {
    --   enabled = true,
    --   window = { show_documentation = false },
    -- },
  },

  opts_extend = { 'sources.default' },
}

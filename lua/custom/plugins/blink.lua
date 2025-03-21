return {
  'saghen/blink.cmp',

  event = 'InsertEnter',
  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'super-tab' },

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
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },

      menu = {
        draw = {
          treesitter = { 'lsp' },
        },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },

      ghost_text = {
        enabled = true,
      },
    },

    -- Experimental
    -- signature = { enabled = true },
  },

  opts_extend = { 'sources.default' },
}

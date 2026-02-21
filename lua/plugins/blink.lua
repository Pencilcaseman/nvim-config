local add, later = PackMan.add, PackMan.later

later(function()
  add 'https://github.com/xzbdmw/colorful-menu.nvim'
end)

later(function()
  if vim.g.vscode then
    return
  end

  add {
    src = 'https://github.com/saghen/blink.cmp',
    version = 'main',
    hooks = {
      post_install = function()
        vim.notify 'Building blink.cmp from source...'
        vim.cmd 'BlinkCmp build'
      end,
      post_checkout = function()
        vim.notify 'Building blink.cmp from source...'
        vim.cmd 'BlinkCmp build'
      end,
    },
  }

  require('blink.cmp').setup {
    keymap = { preset = 'super-tab' },

    fuzzy = {
      implementation = 'prefer_rust',
    },

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

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    completion = {
      trigger = {
        show_on_trigger_character = true,
      },

      menu = {
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
        auto_show = true,
        auto_show_delay_ms = 200,
      },

      ghost_text = {
        enabled = true,
      },
    },

    -- Experimental
    signature = { enabled = true },
  }
end)

local add, later = PackMan.add, PackMan.later

local build_nightly = function(name)
  return function(params)
    vim.notify('Building blink.' .. name, vim.log.levels.INFO)
    local obj = vim
      .system({ 'cargo', '+nightly', 'build', '--release' }, {
        cwd = params.path,
      })
      :wait()
    if obj.code == 0 then
      vim.notify('Building blink.' .. name .. ' done', vim.log.levels.INFO)
    else
      vim.notify('Building blink.' .. name .. ' failed', vim.log.levels.ERROR)
    end
  end
end

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
      post_checkout = build_nightly 'cmp',
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

later(function()
  add {
    src = 'saghen/blink.pairs',
    version = 'main',
    hooks = {
      post_checkout = build_nightly 'pairs',
    },
  }

  require('blink.pairs').setup {
    mappings = {
      enabled = true,
      cmdline = true,
      disabled_filetypes = {},
    },
    highlights = {
      enabled = true,
      cmdline = true,

      matchparen = {
        enabled = true,
        cmdline = true,
        include_surrounding = true,
      },
    },
  }
end)

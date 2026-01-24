local add = MiniDeps.add
local now_if_args = _G.Config.now_if_args

local function build_blink(params)
  vim.notify('Building blink.cmp', vim.log.levels.INFO)
  local obj = vim.system({ 'cargo', '+nightly', 'build', '--release' }, { cwd = params.path }):wait()
  if obj.code == 0 then
    vim.notify('Building blink.cmp done', vim.log.levels.INFO)
  else
    vim.notify('Building blink.cmp failed', vim.log.levels.ERROR)
  end
end

now_if_args(function()
  if vim.g.vscode then
    return
  end

  add {
    source = 'saghen/blink.cmp',
    checkout = 'main',
    hooks = {
      post_install = build_blink,
      post_checkout = build_blink,
    },
    depends = {
      'xzbdmw/colorful-menu.nvim',
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
  }
end)

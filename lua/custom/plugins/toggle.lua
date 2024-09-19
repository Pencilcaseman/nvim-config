return {
  'gregorias/toggle.nvim',
  event = 'VeryLazy',
  version = '2.0',
  config = function()
    require('toggle').setup {
      keymaps = {
        toggle_option_prefix = '<leader>u',
        previous_option_prefix = '[o',
        next_option_prefix = ']o',
        status_dashboard = '<leader>uo',
      },
      -- The interface for registering keymaps.
      keymap_registry = require('toggle.keymap').keymap_registry(),
      -- See the default options section below.
      options_by_keymap = {},
      --- Whether to notify when a default option is set.
      notify_on_set_default_option = true,
    }

    local toggle = require 'toggle'

    toggle.register(
      'i',
      -- Disables or enables inlay hints for the current buffer.
      toggle.option.NotifyOnSetOption(toggle.option.OnOffOption {
        name = 'inlay hints',
        get_state = function()
          return vim.lsp.inlay_hint.is_enabled()
        end,
        set_state = function(new_value)
          vim.lsp.inlay_hint.enable(new_value)
        end,
      }),
      {}
    )
  end,
}

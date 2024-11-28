local utils = require 'utils'

-- Not a required plugin
if utils.is_minimal() then
  return {}
end

return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    statusline = {
      enabled = false,
    },

    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
    },

    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },

    routes = {
      {
        filter = {
          event = 'msg_show',
          kind = '',
          find = 'written',
        },
        opts = { skip = true },
      },
    },

    -- routes = {
    --   {
    --     filter = {
    --       event = 'msg_show',
    --       any = {
    --         { find = '%d+L, %d+B' },
    --         { find = '; after #%d+' },
    --         { find = '; before #%d+' },
    --       },
    --     },
    --     view = 'mini',
    --   },
    -- },
  },

  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      'rcarriga/nvim-notify',
      opts = {
        timeout = 1000,
        -- render = 'compact',
        stages = 'slide',
        top_down = false,
      },
    },
  },

  config = function(_, opts)
    require('noice').setup(opts)
  end,
}

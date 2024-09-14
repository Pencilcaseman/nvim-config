return {
  'romgrk/barbar.nvim',
  lazy = false,
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    -- Configure barbar here
    animation = true,
    auto_hide = false,
    tabpages = true,
    clickable = true,
    --
    -- Disable highlighting alternate buffers
    highlight_alternate = false,

    -- Disable highlighting file icons in inactive buffers
    highlight_inactive_file_icons = false,

    -- Enable highlighting visible buffers
    highlight_visible = false,

    icons = {
      buffer_index = true,
      buffer_number = false,
      button = '',

      -- Use the default icons for diagnostics
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true },
        [vim.diagnostic.severity.WARN] = { enabled = true },
        [vim.diagnostic.severity.INFO] = { enabled = true },
        [vim.diagnostic.severity.HINT] = { enabled = true },
      },

      gitsigns = {
        added = { enabled = true, icon = '+' },
        changed = { enabled = true, icon = '~' },
        deleted = { enabled = true, icon = '-' },
      },

      filetype = {
        custom_colors = false,
        enabled = true,
      },

      separator = { left = '', right = '' },
      modified = { button = '󰧞' },
      pinned = { button = '󰐃', filename = true },
      alternate = { filetype = { enabled = false } },
      current = { buffer_index = true },
      inactive = { button = '' },
      visible = { modified = { buffer_number = false } },
    },

    insert_at_end = true,
    insert_at_start = false,
    maximum_padding = 1,
    minimum_padding = 1,
    maximum_length = 30,
    semantic_letters = true,
    letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
    no_name_title = nil,
  },
  keys = function(_, keys)
    return {
      { 'H', '<CMD>BufferPrevious<CR>', desc = 'Move to the left buffer' },
      { 'L', '<CMD>BufferNext<CR>', desc = 'Move to the right buffer' },

      { '<space>bp', '<CMD>BufferPin<CR>', desc = 'Pin the current buffer' },
      { '<space>bc', '<CMD>BufferClose<CR>', desc = 'Close the current buffer' },
      { '<space>bC', '<CMD>BufferCloseAllButCurrent<CR>', desc = 'Close all but the current buffer' },
      { '<space>bg', '<CMD>BufferPick<CR>', desc = 'Magic pick buffers' },

      { '<S-left>', '<CMD>BufferMovePrevious<CR>', desc = 'Move the current buffer left' },
      { '<S-right>', '<CMD>BufferMoveNext<CR>', desc = 'Move the current buffer right' },

      unpack(keys),
    }
  end,

  config = function(_, fn_opts)
    require('barbar').setup(fn_opts)
  end,
}

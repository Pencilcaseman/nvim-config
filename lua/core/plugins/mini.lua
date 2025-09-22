return {
  'echasnovski/mini.nvim',
  event = 'VeryLazy',
  version = false,
  config = function()
    require('mini.ai').setup()
    require('mini.comment').setup()
    require('mini.pairs').setup()
    require('mini.surround').setup {
      mappings = {
        add = 'ra', -- Add surrounding in Normal and Visual modes
        delete = 'rd', -- Delete surrounding
        find = 'rf', -- Find surrounding (to the right)
        find_left = 'rF', -- Find surrounding (to the left)
        highlight = 'rh', -- Highlight surrounding
        replace = 'rr', -- Replace surrounding

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    }
    require('mini.bracketed').setup()
    require('mini.files').setup()
    require('mini.colors').setup()
  end,

  keys = {
    {
      '<leader>e',
      function()
        if MiniFiles.get_explorer_state() then
          MiniFiles.close()
        else
          MiniFiles.open()
        end
      end,
      desc = 'File [E]xplorer',
    },
    {
      '<leader>E',
      function()
        if MiniFiles.get_explorer_state() then
          MiniFiles.close()
        else
          MiniFiles.open(vim.api.nvim_buf_get_name(0))
        end
      end,
      desc = 'File [E]xplorer',
    },
  },
}

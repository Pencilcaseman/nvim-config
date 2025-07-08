return {
  'nvim-neo-tree/neo-tree.nvim',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },

  opts = {},

  keys = {
    { '<leader>e', '<Cmd>Neotree reveal toggle<CR>', desc = 'File [E]xplorer' },
  },
}

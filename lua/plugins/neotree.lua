return {
  'nvim-neo-tree/neo-tree.nvim',
  -- branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    { '3rd/image.nvim', opts = {} },
  },

  lazy = false,

  opts = {},

  keys = {

    { '<leader>e', '<Cmd>Neotree toggle<CR>', desc = 'File [E]xplorer' },
  },
}

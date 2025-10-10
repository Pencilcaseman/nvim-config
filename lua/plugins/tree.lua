return {
  {
    'nvim-neo-tree/neo-tree.nvim',

    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },

    keys = {
      { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'File [E]xplorer' },
    },
  },
}

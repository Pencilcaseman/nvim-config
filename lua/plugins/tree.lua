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
      { '<leader>fe', '<cmd>Neotree toggle reveal<cr>', desc = '[F]ind File in [E]xplorer' },
      { '<leader>E', '<cmd>Neotree toggle current<cr>', desc = 'File [E]xplorer in Current Tab' },
    },
  },
}

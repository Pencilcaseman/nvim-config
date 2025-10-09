return {
  {
    'nvim-neo-tree/neo-tree.nvim',

    -- There's an annoying bug after this release
    -- TODO: Update when fixed
    tag = '3.35',
    -- branch = 'v3.x',

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

return {
  'stevearc/aerial.nvim',
  opts = {
    layout = {
      max_width = { 40, 0.2 },
      min_width = { 40, 0.2 },
    },
  },

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },

  keys = {
    { '<leader>a', '<cmd>AerialToggle!<cr>', desc = '[A]erial Open' },
  },
}

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'yavorski/lualine-macro-recording.nvim',
  },
  opts = {
    extensions = {
      'fzf',
      'mason',
      'neo-tree',
      'nvim-dap-ui',
      'overseer',
      'toggleterm',
    },

    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename', 'macro_recording' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },

    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
  },
  config = function(_, opts)
    require('lualine').setup(opts)
  end,
}

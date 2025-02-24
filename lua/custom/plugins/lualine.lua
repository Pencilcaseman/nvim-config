return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    -- 'nvim-tree/nvim-web-devicons',
    'yavorski/lualine-macro-recording.nvim',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  opts = {
    icons_enabled = vim.g.have_nerd_font,

    extensions = {
      'fzf',
      'mason',
      'nvim-dap-ui',
      'overseer',
      'toggleterm',
    },

    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(str)
            -- Formats as:
            -- NORMAL => NOR
            -- INSERT => INS
            -- VISUAL => VIS
            return str:sub(1, 3)
          end,
        },
      },
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

    tabline = {
      lualine_a = { 'buffers' },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  },

  config = function(_, opts)
    require('lualine').setup(opts)
  end,

  keys = {
    { 'H', ':bprevious<CR>', desc = 'Move to the left buffer', silent = true },
    { 'L', ':bnext<CR>', desc = 'Move to the right buffer', silent = true },
    { '<leader>bc', ':bdelete<CR>', desc = 'Close the current buffer', silent = true },

    {
      '<leader>bC',
      function()
        local current_buf = vim.api.nvim_get_current_buf()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end,
      desc = 'Close all buffers except the current one',
    },
  },
}

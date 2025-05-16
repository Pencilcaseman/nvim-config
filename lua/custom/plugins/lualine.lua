local function selection_count()
  if vim.fn.mode():find '[vV]' then
    local counts = vim.fn.wordcount()

    local starts = vim.fn.line 'v'
    local ends = vim.fn.line '.'
    local lines = starts <= ends and ends - starts + 1 or starts - ends + 1

    return string.format('L:%d W:%d C:%d', lines, counts.visual_words, counts.visual_chars)
  else
    return ''
  end
end

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'yavorski/lualine-macro-recording.nvim',
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
      lualine_x = { selection_count, 'encoding', 'fileformat', 'filetype' },
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

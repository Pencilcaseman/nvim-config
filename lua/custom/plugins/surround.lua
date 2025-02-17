return {
  'kylechui/nvim-surround',
  event = 'VeryLazy',
  opts = {
    keymaps = {
      -- insert = '<C-g>s',
      -- insert_line = '<C-g>S',
      normal = 'gs',
      normal_cur = 'gSs',
      normal_line = 'gS',
      normal_cur_line = 'gSS',
      visual = 'g',
      visual_line = 'gS',
      delete = 'gsd',
      change = 'gsc',
      change_line = 'gsC',
    },
  },
  -- config = function(_, opts)
  --   require('nvim-surround').setup {
  --     -- Configuration here, or leave empty to use defaults
  --   }
  -- end,
}

-- Sample Line

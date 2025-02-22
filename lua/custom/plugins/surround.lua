return {
  'kylechui/nvim-surround',
  event = 'VeryLazy',
  opts = {
    keymaps = {
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
}

return {
  'https://github.com/rmagatti/goto-preview.git',

  opts = {},

  config = true,

  keys = {
    { 'gp', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = '[G]oto Definition [P]review' },
  },
}

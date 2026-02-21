local add, later = PackMan.add, PackMan.later

later(function()
  add 'https://github.com/chentoast/marks.nvim'
  require('marks').setup {
    -- builtin_marks = {
    --   '.',
    --   '<',
    --   '>',
    --   '^',
    --   '`',
    -- },
  }
end)

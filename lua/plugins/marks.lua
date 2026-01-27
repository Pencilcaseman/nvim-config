local later, add = MiniDeps.later, MiniDeps.add

later(function()
  add 'chentoast/marks.nvim'
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

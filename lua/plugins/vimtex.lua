local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add 'lervag/vimtex'

  vim.g.vimtex_view_method = 'skim'
  vim.g.vimtex_complete_enabled = 1
  vim.g.vimtex_matchparen_enabled = 1
  vim.g.vimtex_syntax_enabled = 1
  vim.g.vimtex_fold_enabled = 0
end)

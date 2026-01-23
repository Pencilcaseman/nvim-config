local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add { source = 'chomosuke/typst-preview.nvim', hooks = {
    post_checkout = function()
      require('typst-preview').update()
    end,
  } }

  vim.g.vimtex_view_method = 'skim'
  vim.g.vimtex_complete_enabled = 1
  vim.g.vimtex_matchparen_enabled = 1
  vim.g.vimtex_syntax_enabled = 1
  vim.g.vimtex_fold_enabled = 0
end)

return {
  'lervag/vimtex',

  ft = 'tex',

  init = function()
    vim.g.vimtex_view_method = 'skim'
  end,

  config = function()
    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_complete_enabled = 1
    vim.g.vimtex_matchparen_enabled = 1
    vim.g.vimtex_syntax_enabled = 1
    vim.g.vimtex_fold_enabled = 0
  end,
}

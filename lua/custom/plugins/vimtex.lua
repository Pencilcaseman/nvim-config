return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  init = function()
    -- VimTeX configuration goes here, e.g.
    -- vim.g.vimtex_view_method = 'skim'
  end,
  opts = {},
  config = function(_, opts)
    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_complete_enabled = 1
    vim.g.vimtex_matchparen_enabled = 1
    vim.g.vimtex_syntax_enabled = 1
    vim.g.vimtex_fold_enabled = 0 -- I can't decide, but I think this is horrible
  end,
}

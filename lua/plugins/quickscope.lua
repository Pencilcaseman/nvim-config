return {
  'unblevable/quick-scope',

  event = 'LazyFile',

  config = function()
    -- We have to delay the highlight until after the colorscheme is loaded
    vim.defer_fn(function()
      vim.cmd [[highlight QuickScopePrimary guifg=#FE8018 guibg=none gui=underline,bold cterm=underline,bold]]
      vim.cmd [[highlight QuickScopeSecondary guifg=#51A0CF guibg=none gui=underline,bold cterm=underline,bold]]
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    end, 500)
  end,
}

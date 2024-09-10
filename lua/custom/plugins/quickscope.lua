return {
  'unblevable/quick-scope',
  event = 'VeryLazy',
  config = function()
    vim.cmd [[highlight QuickScopePrimary guifg=#ff0000 guibg=none]]
    vim.cmd [[highlight QuickScopeSecondary guifg=#00ff00 guibg=none]]

    vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }

    -- stylua: ignore
    vim.g.qs_accepted_chars = {

      -- Lowercase
      'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',

      -- Uppercase
      -- 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',

      -- Numbers
      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    }
    -- stylua: ignore
  end,
}

return {
  'cpea2506/one_monokai.nvim',
  opts = {
    transparent = true,
  },
  config = function(_, opts)
    require('one_monokai').setup(opts)

    vim.cmd [[highlight FlashLabel guibg=#75FE40 guifg=#202060 gui=bold]]
    vim.cmd [[highlight CursorLine guibg=#282A2E]]
  end,
}

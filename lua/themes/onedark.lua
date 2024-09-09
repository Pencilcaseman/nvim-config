return {
  'navarasu/onedark.nvim',
  opts = {
    style = 'deep',
  },
  config = function(_, opts)
    require('onedark').setup(opts)
    require('onedark').load()

    vim.cmd [[highlight BufferCurrentCHANGED guibg=default guifg=none]]
    vim.cmd [[highlight BufferCurrentDELETED guibg=default guifg=none]]
    vim.cmd [[highlight BufferCurrentADDED guibg=default guifg=none]]
  end,
}

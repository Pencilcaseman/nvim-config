return {
  'navarasu/onedark.nvim',
  event = 'ColorScheme',
  opts = {
    style = 'deep',
  },
  config = function(_, opts)
    require('onedark').setup(opts)
    require('onedark').load()

    vim.cmd [[highlight BufferCurrentCHANGED guibg=#1A1B26 guifg=#6B71F2]]
    vim.cmd [[highlight BufferCurrentDELETED guibg=#1A1B26 guifg=#E55444]]
    vim.cmd [[highlight BufferCurrentADDED guibg=#1A1B26 guifg=#43E661]]

    vim.cmd [[highlight BufferVisibleCHANGED guibg=#212331 guifg=#6B71F2]]
    vim.cmd [[highlight BufferVisibleDELETED guibg=#212331 guifg=#E55444]]
    vim.cmd [[highlight BufferVisibleADDED guibg=#212331 guifg=#43E661]]

    vim.cmd [[highlight BufferAlternateCHANGED guibg=#212331 guifg=#6B71F2]]
    vim.cmd [[highlight BufferAlternateDELETED guibg=#212331 guifg=#E55444]]
    vim.cmd [[highlight BufferAlternateADDED guibg=#212331 guifg=#43E661]]
  end,
}

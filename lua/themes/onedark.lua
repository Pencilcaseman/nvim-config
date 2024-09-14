return {
  'navarasu/onedark.nvim',
  -- event = 'ColorScheme',
  event = 'VimEnter',
  opts = {
    style = 'deep',
    toggle_style_key = '<leader>ts',
  },
  config = function(_, opts)
    require('onedark').setup(opts)
    require('onedark').load()
    vim.cmd [[colorscheme onedark]]

    -- Gitsigns
    vim.cmd [[highlight BufferCurrentCHANGED guibg=#19212E guifg=#6B71F2]]
    vim.cmd [[highlight BufferCurrentDELETED guibg=#19212E guifg=#E55444]]
    vim.cmd [[highlight BufferCurrentADDED guibg=#19212E guifg=#43E661]]

    vim.cmd [[highlight BufferVisibleCHANGED guibg=#19212E guifg=#6B71F2]]
    vim.cmd [[highlight BufferVisibleDELETED guibg=#19212E guifg=#E55444]]
    vim.cmd [[highlight BufferVisibleADDED guibg=#19212E guifg=#43E661]]

    vim.cmd [[highlight BufferInactiveCHANGED guibg=#19212E guifg=#6B71F2]]
    vim.cmd [[highlight BufferInactiveDELETED guibg=#19212E guifg=#E55444]]
    vim.cmd [[highlight BufferInactiveADDED guibg=#19212E guifg=#43E661]]

    vim.cmd [[highlight BufferAlternateCHANGED guibg=#19212E guifg=#6B71F2]]
    vim.cmd [[highlight BufferAlternateDELETED guibg=#19212E guifg=#E55444]]
    vim.cmd [[highlight BufferAlternateADDED guibg=#19212E guifg=#43E661]]

    -- LSP information
    vim.cmd [[highlight BufferCurrentERROR guibg=#19212E guifg=#E55444]]
    vim.cmd [[highlight BufferCurrentWARN guibg=#19212E guifg=#F6B761]]
    vim.cmd [[highlight BufferCurrentINFO guibg=#19212E guifg=#6B71F2]]
    vim.cmd [[highlight BufferCurrentHINT guibg=#19212E guifg=#6B71F2]]

    vim.cmd [[highlight BufferVisibleERROR guibg=#19212E guifg=#E55444]]
    vim.cmd [[highlight BufferVisibleWARN guibg=#19212E guifg=#F6B761]]
    vim.cmd [[highlight BufferVisibleINFO guibg=#19212E guifg=#6B71F2]]
    vim.cmd [[highlight BufferVisibleHINT guibg=#19212E guifg=#6B71F2]]

    vim.cmd [[highlight BufferInactiveERROR guibg=#19212E guifg=#E55444]]
    vim.cmd [[highlight BufferInactiveWARN guibg=#19212E guifg=#F6B761]]
    vim.cmd [[highlight BufferInactiveINFO guibg=#19212E guifg=#6B71F2]]
    vim.cmd [[highlight BufferInactiveHINT guibg=#19212E guifg=#6B71F2]]

    vim.cmd [[highlight BufferAlternateERROR guibg=#19212E guifg=#E55444]]
    vim.cmd [[highlight BufferAlternateWARN guibg=#19212E guifg=#F6B761]]
    vim.cmd [[highlight BufferAlternateINFO guibg=#19212E guifg=#6B71F2]]
    vim.cmd [[highlight BufferAlternateHINT guibg=#19212E guifg=#6B71F2]]

    -- Filename
    vim.cmd [[highlight BufferCurrent guibg=#19212E guifg=#00A3CC gui=bold]]
    vim.cmd [[highlight BufferVisible guibg=#19212E guifg=#33879C]]
    vim.cmd [[highlight BufferInactive guibg=#19212E guifg=#33879C]]
    vim.cmd [[highlight BufferAlternate guibg=#19212E guifg=#33879C]]

    -- Tab numbers
    vim.cmd [[highlight BufferCurrentIndex guibg=#19212E guifg=#00A3CC gui=bold]]
    vim.cmd [[highlight BufferVisibleIndex guibg=#19212E guifg=#33879C]]
    vim.cmd [[highlight BufferInactiveIndex guibg=#19212E guifg=#33879C]]
    vim.cmd [[highlight BufferAlternateIndex guibg=#19212E guifg=#33879C]]

    -- Active line number
    vim.cmd [[highlight LineNrAbove guibg=#19212E guifg=#516C96]]
    vim.cmd [[highlight LineNrBelow guibg=#19212E guifg=#716CB6]]
    vim.cmd [[highlight CursorLineNr guibg=#19212E guifg=#469EDA gui=bold]]
  end,
}

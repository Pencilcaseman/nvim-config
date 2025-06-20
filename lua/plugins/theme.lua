return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd [[colorscheme tokyonight]]

    vim.cmd [[highlight LineNrAbove guifg=#516C96]]
    vim.cmd [[highlight LineNrBelow guifg=#516C96]]

    -- vim.cmd [[highlight DiagnosticUnnecessary guifg=#8D9D90]]
    vim.cmd [[highlight DiagnosticUnnecessary guifg=#A39594]]

    vim.cmd [[highlight BufferCurrentCHANGED guibg=#222436 guifg=#6B71F2]]
    vim.cmd [[highlight BufferCurrentDELETED guibg=#222436 guifg=#E55444]]
    vim.cmd [[highlight BufferCurrentADDED guibg=#222436 guifg=#43E661]]

    vim.cmd [[highlight BufferVisibleCHANGED guibg=#282A3F guifg=#6B71F2]]
    vim.cmd [[highlight BufferVisibleDELETED guibg=#282A3F guifg=#E55444]]
    vim.cmd [[highlight BufferVisibleADDED guibg=#282A3F guifg=#43E661]]

    vim.cmd [[highlight BufferInactiveCHANGED guibg=#282A3F guifg=#6B71F2]]
    vim.cmd [[highlight BufferInactiveDELETED guibg=#282A3F guifg=#E55444]]
    vim.cmd [[highlight BufferInactiveADDED guibg=#282A3F guifg=#43E661]]

    vim.cmd [[highlight BufferAlternateCHANGED guibg=#282A3F guifg=#6B71F2]]
    vim.cmd [[highlight BufferAlternateDELETED guibg=#282A3F guifg=#E55444]]
    vim.cmd [[highlight BufferAlternateADDED guibg=#282A3F guifg=#43E661]]

    if vim.g.neovide then
      vim.opt.guifont = 'Monaspace Radon Var'
    end
  end,
}

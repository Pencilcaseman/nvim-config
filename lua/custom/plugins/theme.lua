return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd [[colorscheme tokyonight]]

    vim.cmd [[highlight LineNrAbove guifg=#516C96]]
    vim.cmd [[highlight LineNrBelow guifg=#516C96]]
  end,
}

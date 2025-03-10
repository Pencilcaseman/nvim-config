return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd [[colorscheme tokyonight]]

    vim.cmd [[highlight LineNrAbove guifg=#516C96]]
    vim.cmd [[highlight LineNrBelow guifg=#516C96]]

    if vim.g.neovide then
      -- This is a comment
      -- vim.cmd [[ highlight Comment guifont="Monaspace Radon Var"]]
      vim.opt.guifont = 'Monaspace Radon Var'
    end
  end,
}

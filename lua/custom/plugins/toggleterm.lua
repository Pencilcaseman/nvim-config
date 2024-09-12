return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {--[[ things you want to change go here]]
    -- Shell is $HOME/.nix-profile/bin/fish
    shell = vim.env.HOME .. '/.nix-profile/bin/fish',
  },
}

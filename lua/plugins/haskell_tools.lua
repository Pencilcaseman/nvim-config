local add, now = MiniDeps.add, MiniDeps.now

now(function()
  add {
    source = 'mrcjkb/haskell-tools.nvim',
    depends = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
  }
end)

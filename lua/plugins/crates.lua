local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add 'saecki/crates.nvim'

  require('crates').setup {
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
  }
end)

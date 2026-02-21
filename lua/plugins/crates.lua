local add, later = PackMan.add, PackMan.later

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

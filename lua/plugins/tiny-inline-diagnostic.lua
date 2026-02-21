local add, later = PackMan.add, PackMan.later

later(function()
  add 'https://github.com/rachartier/tiny-inline-diagnostic.nvim'

  require('tiny-inline-diagnostic').setup {
    preset = 'powerline',

    options = {
      multilines = {
        enabled = true,
      },
    },
  }

  -- Disable Neovim's default virtual text diagnostics
  vim.diagnostic.config { virtual_text = false }
end)

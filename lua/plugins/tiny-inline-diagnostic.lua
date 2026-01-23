local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = _G.Config.now_if_args

later(function()
  add 'rachartier/tiny-inline-diagnostic.nvim'

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

-- local theme = 'tokyonight'
local theme = 'monokai-pro'

if theme == 'tokyonight' then
  return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd [[colorscheme tokyonight]]

      vim.cmd [[highlight LineNrAbove guifg=#516C96]]
      vim.cmd [[highlight LineNrBelow guifg=#516C96]]

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
elseif theme == 'monokai-pro' then
  return {
    'loctvl842/monokai-pro.nvim',

    lazy = false,
    priority = 1000,

    opts = {
      filter = 'pro',

      -- From https://github.com/loctvl842/monokai-pro.nvim/issues/143
      override = function(c)
        local hp = require 'monokai-pro.color_helper'
        local common_fg = hp.lighten(c.sideBar.foreground, 30)
        return {
          SnacksPicker = { bg = c.editor.background, fg = common_fg },
          SnacksPickerBorder = { bg = c.editor.background, fg = c.tab.unfocusedActiveBorder },
          SnacksPickerTree = { fg = c.editorLineNumber.foreground },
          NonText = { fg = c.base.dimmed3 },
        }
      end,
    },

    config = function(_, opts)
      require('monokai-pro').setup(opts)

      vim.cmd [[colorscheme monokai-pro]]

      vim.cmd [[highlight LazyGitBorder     guibg=#FF0000 guifg=#00FF00]]
      vim.cmd [[highlight BufferTabpageFill guibg=#2C2A2E]]
      vim.cmd [[highlight LazyGitBorder     guibg=#AC9CF2 guifg=#AC9CF2]]

      vim.cmd [[highlight FidgetTitle  guifg=#C792EA gui=bold]]
      vim.cmd [[highlight FidgetTask   guifg=#FFFFFF]]
      vim.cmd [[highlight FidgetNormal guibg=#2A2A2A]]
      vim.cmd [[highlight FidgetDone   guifg=#A0E8A0]]
      vim.cmd [[highlight FidgetSpin   guifg=#61AFEF]]

      vim.cmd [[highlight FidgetProgressBar guibg=#61AFEF]]
      vim.cmd [[highlight FidgetProgressText  guifg=#000000 gui=bold]]

      vim.cmd [[highlight FlashMatch guibg=#4E3188]]
      vim.cmd [[highlight FlashLabel guibg=#134881 guifg=#54D2FB gui=bold]]

      if vim.g.neovide then
        vim.opt.guifont = 'Monaspace Radon Var'
      end
    end,
  }
else
  return {}
end

-- local theme = 'tokyonight'
-- local theme = 'monokai-pro'
-- local theme = 'onedarkpro'
-- local theme = 'catppuccin'
local theme = 'kanagawa'
-- local theme = 'none'

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

      vim.cmd [[highlight FlashMatch guibg=#2D4561]]
      vim.cmd [[highlight FlashLabel guibg=#2D4561 guifg=#81FFFF gui=bold]]

      if vim.g.neovide then
        vim.opt.guifont = 'Monaspace Radon Var'
      end
    end,
  }
elseif theme == 'onedarkpro' then
  return {
    'olimorris/onedarkpro.nvim',

    lazy = false,
    priority = 1000,

    opts = {},

    config = function(_, opts)
      require('onedarkpro').setup(opts)

      vim.cmd [[colorscheme onedark_vivid]]
    end,
  }
elseif theme == 'catppuccin' then
  return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,

    opts = {
      default_integrations = false,

      integrations = {
        barbar = true,
        barbecue = {
          dim_dirname = true, -- directory name is dimmed by default
          bold_basename = true,
          dim_context = false,
          alt_background = false,
        },
        fidget = true,
        flash = true,
        gitsigns = true,
        grug_far = true,
        indent_blankline = {
          enabled = true,
          scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = false,
        },
        mason = true,
        neotree = true,
        noice = true,
        dap = true,
        dap_ui = true,

        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
            ok = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
            ok = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },

        notify = true,

        nvim_surround = true,
        treesitter = true,
        overseer = true,
        render_markdown = true,
        which_key = true,
      },
    },

    config = function(_, opts)
      require('catppuccin').setup(opts)

      vim.cmd [[colorscheme catppuccin-mocha]]
    end,
  }
elseif theme == 'kanagawa' then
  return {
    'rebelot/kanagawa.nvim',

    opts = {
      compile = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      colors = {
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors)
        return {}
      end,
      theme = 'wave',
      background = {
        dark = 'wave',
        light = 'lotus',
      },
    },

    config = function(_, opts)
      require('kanagawa').setup(opts)

      vim.cmd [[colorscheme kanagawa]]
    end,
  }
else
  return {}
end

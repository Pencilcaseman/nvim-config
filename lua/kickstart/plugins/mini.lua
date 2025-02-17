return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    version = false,
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      -- require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - maiw) - [M]odify [A]dd [I]nner [W]ord [)]Paren
      -- - md'   - [M]odify [D]elete [']quotes
      -- - mr)'  - [M]odify [R]eplace [)] [']
      -- require('mini.surround').setup {
      --   mappings = {
      --     add = 'ma',
      --     delete = 'md',
      --     find = 'mf',
      --     find_left = 'mF',
      --     highlight = 'mh',
      --     replace = 'mr',
      --     update_n_lines = 'mn',
      --
      --     suffix_last = 'l',
      --     suffix_next = 'n',
      --   },
      -- }

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      -- local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et

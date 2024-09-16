return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'cpp', 'python', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },

      indent = {
        enable = true,
        disable = {
          'ruby',
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  -- {
  --   'nvim-treesitter/nvim-treesitter-context',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter' },
  --   event = 'VeryLazy',
  --   opts = {
  --     enable = true,
  --   },
  -- },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    opts = {
      ensure_installed = 'all', -- or a list of languages you want to ensure are installed
      indent = {
        enable = true,
      },
      highlight = {
        enable = true,

        additional_vim_regex_highlighting = {
          'ruby',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = { query = '@function.outer', desc = '[A]round [F]unction' },
            ['if'] = { query = '@function.inner', desc = '[I]nner [F]unction' },
            ['ac'] = { query = '@class.outer', desc = '[A]rrow [C]lass' },
            ['ic'] = { query = '@class.inner', desc = '[I]nner [C]lass' },
            ['al'] = { query = '@loop.outer', desc = '[A]rrow [L]oop' },
            ['il'] = { query = '@loop.inner', desc = '[I]nner [L]oop' },
            ['ab'] = { query = '@block.outer', desc = '[A]rrow [B]lock' },
            ['ib'] = { query = '@block.inner', desc = '[I]nner [B]lock' },
          },
          -- You can choose the select mode (default is charwise 'v')
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          include_surrounding_whitespace = false,
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et

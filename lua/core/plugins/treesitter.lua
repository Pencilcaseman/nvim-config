return {
  {
    'nvim-treesitter/nvim-treesitter',

    version = false,
    -- event = 'VeryLazy',
    event = { 'BufReadPost', 'BufNewFile' },

    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',

    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },

    opts = {
      sync_install = false,

      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'python',
        'diff',
        'html',
        'lua',
        'markdown',
        'markdown_inline',
        'vim',
        'vimdoc',
        'bibtex',
        'rust',
      },

      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },

    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require('lazy.core.loader').add_to_rtp(plugin)
      require 'nvim-treesitter.query_predicates'
    end,

    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },

    event = 'VeryLazy',

    opts = {
      auto_install = true,
      indent = {
        enable = true,
      },
      highlight = {
        enable = true,

        additional_vim_regex_highlighting = {
          -- 'ruby',
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
            ['ac'] = { query = '@class.outer', desc = '[A]round [C]lass' },
            ['ic'] = { query = '@class.inner', desc = '[I]nner [C]lass' },
            ['al'] = { query = '@loop.outer', desc = '[A]round [L]oop' },
            ['il'] = { query = '@loop.inner', desc = '[I]nner [L]oop' },
            ['ab'] = { query = '@block.outer', desc = '[A]round [B]lock' },
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

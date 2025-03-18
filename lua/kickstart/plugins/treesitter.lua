return {
  {
    'nvim-treesitter/nvim-treesitter',

    -- event = 'VeryLazy',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    lazy = true,

    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
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
      -- Tex support
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'bibtex' })
      end
      if type(opts.highlight.disable) == 'table' then
        vim.list_extend(opts.highlight.disable, { 'latex' })
      else
        opts.highlight.disable = { 'latex' }
      end

      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { { 'nvim-treesitter/nvim-treesitter', event = 'VeryLazy' } },

    -- event = 'VeryLazy',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },

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

local add, later = MiniDeps.add, MiniDeps.later
local now_if_args = _G.Config.now_if_args

local ts_langs = {
  'bash',
  'c',
  'c_sharp',
  'cpp',
  'css',
  'csv',
  'diff',
  'dockerfile',
  'elixir',
  'git_config',
  'gitcommit',
  'gitignore',
  'go',
  'gomod',
  'graphql',
  'haskell',
  'heex',
  'html',
  'ini',
  'java',
  'javascript',
  'jsdoc',
  'json',
  'lua',
  'luadoc',
  'make',
  'markdown',
  'markdown_inline',
  'php',
  'python',
  'query',
  'regex',
  'rust',
  'scss',
  'sql',
  'svelte',
  'terraform',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'vue',
  'xml',
  'yaml',
}

local ts_post_install = function()
  vim.cmd 'TSUpdate'
end

now_if_args(function()
  add {
    source = 'nvim-treesitter/nvim-treesitter',
    checkout = 'main',
    hooks = {
      post_install = ts_post_install,
      post_checkout = ts_post_install,
    },
  }

  local treesitter = require 'nvim-treesitter'
  treesitter.setup()

  treesitter.install(ts_langs)

  vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function(args)
      local ok = pcall(vim.treesitter.start)

      if ok then
        vim.wo[0][0].foldmethod = 'expr'
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })
end)

later(function()
  add {
    source = 'nvim-treesitter/nvim-treesitter-textobjects',
    checkout = 'main',
  }

  vim.g.no_plugin_maps = true

  require('nvim-treesitter-textobjects').setup {
    select = {
      lookahead = true,
      selection_modes = {
        -- ['@parameter.outer'] = 'v', -- charwise
        -- ['@function.outer'] = 'V', -- linewise
        -- ['@class.outer'] = '<c-v>', -- blockwise
      },

      include_surrounding_whitespace = false,
    },
  }

  local function map_obj(key, query, group)
    local desc = query
      :gsub('^@', '') -- Remove '@'
      :gsub('%.outer$', '') -- Remove '.outer'
      :gsub('%.inner$', '') -- Remove '.inner'
      :gsub('%.lhs$', ' Left') -- '.lhs' -> 'Left'
      :gsub('%.rhs$', ' Right') -- '.rhs' -> 'Right'
      :gsub('%.scope$', '') -- Remove '.scope'
      :gsub('^%l', string.upper) -- Capitalize first letter

    vim.keymap.set({ 'x', 'o' }, key, function()
      require('nvim-treesitter-textobjects.select').select_textobject(query, group or 'textobjects')
    end, {
      desc = desc,
    })
  end

  -- Functions
  map_obj('af', '@function.outer')
  map_obj('if', '@function.inner')

  -- Classes
  map_obj('ac', '@class.outer')
  map_obj('ic', '@class.inner')

  -- Loops (for, while, etc.)
  map_obj('al', '@loop.outer')
  map_obj('il', '@loop.inner')

  -- Conditionals (if, else, switch)
  map_obj('ai', '@conditional.outer')
  map_obj('ii', '@conditional.inner')

  -- Function Calls (e.g. foo(bar))
  map_obj('am', '@call.outer')
  map_obj('im', '@call.inner')

  -- Parameters / Arguments
  map_obj('aa', '@parameter.outer')
  map_obj('ia', '@parameter.inner')

  -- Comments
  map_obj('a/', '@comment.outer')
  map_obj('i/', '@comment.inner')

  -- Assignments (e.g. x = 10)
  map_obj('a=', '@assignment.outer')
  map_obj('i=', '@assignment.inner')
  map_obj('l=', '@assignment.lhs') -- Left-hand side
  map_obj('r=', '@assignment.rhs') -- Right-hand side

  -- Blocks (content inside {})
  map_obj('ab', '@block.outer')
  map_obj('ib', '@block.inner')

  -- Attributes / Decorators
  map_obj('at', '@attribute.outer')
  map_obj('it', '@attribute.inner')

  -- Return statements
  map_obj('ar', '@return.outer')
  map_obj('ir', '@return.inner')

  -- Scopes (using the 'locals' group)
  map_obj('as', '@local.scope', 'locals')
end)

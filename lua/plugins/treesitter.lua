local add = MiniDeps.add
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

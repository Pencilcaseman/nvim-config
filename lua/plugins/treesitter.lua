local add = MiniDeps.add
local now_if_args = _G.Config.now_if_args

local ts_langs = {
  'bash',
  'c',
  'cpp',
  'diff',
  'elixir',
  'git_config',
  'heex',
  'haskell',
  'html',
  'java',
  'java',
  'javascript',
  'json',
  'jsonc',
  'lua',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'regex',
  'rust',
  'toml',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}

local ts_post_install = function()
  require('nvim-treesitter').install(ts_langs, { force = true })
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

  vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function(args)
      local ok = pcall(vim.treesitter.start)

      if ok then
        vim.wo[0][0].foldmethod = 'expr'
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.bo[args.buf].indentexpr = 'v:lua.vim.treesitter.indent.get()'
      end
    end,
  })
end)

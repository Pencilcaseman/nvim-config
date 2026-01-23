local add = MiniDeps.add
local now_if_args = _G.Config.now_if_args

now_if_args(function()
  add {
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = {
      post_checkout = function()
        vim.cmd 'TSUpdateSync'
        vim.cmd 'TSUpdate'
        vim.cmd 'TSInstall'
      end,
    },
  }

  require('nvim-treesitter').setup {
    sync_install = false,
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  }

  vim.api.nvim_create_autocmd('FileType', {
    pattern = { '<filetype>' },
    callback = function()
      -- Start treesitter on file open
      vim.treesitter.start()

      -- Folding
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'
    end,
  })
end)

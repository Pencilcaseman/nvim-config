local add, later = MiniDeps.add, MiniDeps.later
local now_if_args = _G.Config.now_if_args

get_mason_packages = function()
  local packages = {
    'ansible-language-server',
    'ansible-lint',
    'ast-grep',
    'basedpyright',
    'bash-debug-adapter',
    'biome',
    'checkmake',
    'clang-format',
    'clangd',
    'cmakelang',
    'cmakelint',
    'codelldb',
    'debugpy',
    'docker-compose-language-service',
    'dockerfile-language-server',
    'flake8',
    'gersemi',
    'hadolint',
    'harper-ls',
    'haskell-debug-adapter',
    'haskell-language-server',
    'java-debug-adapter',
    'java-test',
    'jdtls',
    'js-debug-adapter',
    'json-lsp',
    'latexindent',
    'lua-language-server',
    'markdownlint',
    'marksman',
    'neocmakelsp',
    'omnisharp',
    'ruff',
    'rust-analyzer',
    'shellcheck',
    'shfmt',
    'stylua',
    'tectonic',
    'tex-fmt',
    'texlab',
    'tinymist',
    'zls',
  }

  return packages
end

now_if_args(function()
  add {
    source = 'mason-org/mason.nvim',
    hooks = {
      post_checkout = function()
        vim.cmd 'MasonUpdate'
      end,
    },
  }

  local ensured_packages = get_mason_packages()

  require('mason').setup {
    PATH = 'append',
    ensure_installed = ensured_packages,
  }

  local mr = require 'mason-registry'
  mr.refresh(function()
    for _, tool in ipairs(ensured_packages) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end)
end)

now_if_args(function()
  add {
    source = 'neovim/nvim-lspconfig',
    depends = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'saghen/blink.cmp',
    },
  }

  local capabilities = require('blink.cmp').get_lsp_capabilities()

  vim.diagnostic.config {
    virtual_text = false,
    signs = false,
    update_in_insert = true,
  }

  local server_configs = {
    tinymist = {
      settings = {
        tinymist = { formatterMode = 'typstyle' },
      },
    },
    clangd = {
      cmd = {
        'clangd',
        '--background-index',
        '-j=8',
        '--clang-tidy',
        '--clang-tidy-checks=*',
        '--all-scopes-completion',
        '--cross-file-rename',
        '--completion-style=detailed',
        '--header-insertion-decorators',
        '--header-insertion=iwyu',
        '--pch-storage=memory',
      },
    },
  }

  for name, cfg in pairs(server_configs) do
    cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})

    vim.lsp.config(name, cfg)
  end

  require('mason-lspconfig').setup {
    automatic_enable = true,
    automatic_installation = true,
  }

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(ev)
      local buf = ev.buf

      local function map(keys, fn, desc)
        vim.keymap.set('n', keys, fn, { buffer = buf, desc = 'LSP: ' .. desc })
      end

      map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      map('gd', vim.lsp.buf.definition, '[G]o to [D]efinition')
      map('gr', vim.lsp.buf.references, '[G]o to [R]eferences')
      map('K', vim.lsp.buf.hover, 'Hover')
    end,
  })
end)

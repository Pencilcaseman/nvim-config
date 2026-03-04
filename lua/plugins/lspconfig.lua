local add, later = PackMan.add, PackMan.later

local get_mason_packages = function()
  local packages = {
    -- Generic
    'ast-grep',
    'harper-ls',

    -- Ansible
    'ansible-language-server',
    'ansible-lint',

    -- Docker
    'docker-compose-language-service',
    'dockerfile-language-server',
    'hadolint',

    -- Bash
    'bash-debug-adapter',
    'shellcheck',
    'shfmt',

    -- JavaScript/TypeScript
    'biome',
    'jdtls',
    'js-debug-adapter',
    'json-lsp',

    -- Make/CMake/C/C++
    'checkmake',
    'clang-format',
    'clangd',
    'cmakelang',
    'cmakelint',
    'codelldb',
    'gersemi',
    'neocmakelsp',

    -- Python
    'debugpy',
    'flake8',
    'ruff',
    'ty',
    'uv',

    -- Haskell
    'haskell-debug-adapter',
    'haskell-language-server',

    -- Java
    'java-debug-adapter',
    'java-test',

    -- TeX/LaTeX
    'latexindent',
    'tectonic',
    'tex-fmt',
    'texlab',

    -- Typst
    'tinymist',

    -- Lua
    'lua-language-server',
    'stylua',

    -- Markdown
    'markdownlint',
    'marksman',

    -- C#
    'omnisharp',

    -- Rust
    'rust-analyzer',

    -- Zig
    'zls',
  }

  return packages
end

later(function()
  add {
    src = 'https://github.com/mason-org/mason.nvim',
    hooks = {
      post_checkout = function()
        -- Trigger this after Mason has been configured
        later(function()
          vim.cmd 'MasonUpdate'
        end)
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

later(function()
  add 'https://github.com/mason-org/mason-lspconfig.nvim'
  add 'https://github.com/neovim/nvim-lspconfig'

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

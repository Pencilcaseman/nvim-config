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
    'hadolint',
    'harper-ls',
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
    'shellcheck',
    'shfmt',
    'stylua',
    'tectonic',
    'texlab',
    'tinymist',
    'zls',
  }

  return packages
end

return {
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',

    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'saghen/blink.cmp',
    },

    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      vim.diagnostic.config {
        virtual_text = false,
        signs = true,
        update_in_insert = true,
      }

      local server_configs = {
        tinymist = {
          settings = {
            tinymist = { formatterMode = 'typstyle' },
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
    end,
  },

  {
    'mason-org/mason.nvim',

    cmd = 'Mason',
    build = ':MasonUpdate',
    opts_extend = { 'ensure_installed' },

    opts = {
      ensure_installed = get_mason_packages(),
    },

    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require 'mason-registry'
      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}

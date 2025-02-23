get_mason_packages = function()
  return {
    'ansible-language-server',
    'ansible-lint',
    'ast-grep',
    'checkmake',
    'clang-format',
    'clangd',
    'cmakelang',
    'cmakelint',
    'codelldb',
    'debugpy',
    'delve',
    'docker-compose-language-service',
    'dockerfile-language-server',
    'eslint-lsp',
    'flake8',
    'hadolint',
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
    'nil',
    'omnisharp',
    'python-lsp-server',
    'ruff-lsp',
    'shellcheck',
    'shfmt',
    'stylua',
    'tectonic',
    'texlab',
    'tinymist',
    'vtsls',
    'zls',
  }
end

return {
  {
    'neovim/nvim-lspconfig',

    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', config = true },
      'saghen/blink.cmp',
    },

    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              diagnostics = { globals = { 'vim', 'require' } },
              workspace = { library = vim.api.nvim_get_runtime_file('', true) },
              telemetry = { enable = false },
            },
          },
        },
        tinymist = {
          settings = { formatterMode = 'typstyle' },
        },
      },
    },

    config = function(_, opts)
      local lspconfig = require 'lspconfig'
      local cmp_capabilities = require('blink.cmp').get_lsp_capabilities()

      require('mason-lspconfig').setup {
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server_opts = opts.servers[server_name] or {}
            server_opts.capabilities = vim.tbl_deep_extend('force', {}, cmp_capabilities, server_opts.capabilities or {})
            lspconfig[server_name].setup(server_opts)
          end,
        },
      }

      -- LSP Keybindings
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local tb = require 'telescope.builtin'
          map('gd', tb.lsp_definitions, '[G]oto [D]efinition')
          map('gr', tb.lsp_references, '[G]oto [R]eferences')
          map('gI', tb.lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', tb.lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', tb.lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>cr', vim.lsp.buf.rename, '[C]ode: Rename')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Toggle inlay hints if supported
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })
    end,
  },

  {
    'williamboman/mason.nvim',
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

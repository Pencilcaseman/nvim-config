get_mason_packages = function()
  return {
    'ansible-language-server',
    'ansible-lint',
    'ast-grep',
    'basedpyright',
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
    'ruff',
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

    event = 'LazyFile',

    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim', config = function() end },
      { 'saghen/blink.cmp' },
    },

    opts = {
      servers = {
        tinymist = {
          settings = { formatterMode = 'typstyle' },
        },
      },
    },

    config = function(_, opts)
      local lspconfig = require 'lspconfig'
      local cmp_capabilities = require('blink.cmp').get_lsp_capabilities()

      vim.diagnostic.config {
        virtual_text = true, -- Show diagnostics inline (virtual text)
        signs = true, -- Show signs in the gutter
        update_in_insert = true, -- Update diagnostics while typing
      }

      require('mason-lspconfig').setup {
        automatic_installation = true,
        ensure_installed = {},
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

          -- Code Actions
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        end,
      })
    end,
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
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

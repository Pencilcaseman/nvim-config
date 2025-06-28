return {
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = 'mason.nvim',
    cmd = { 'DapInstall', 'DapUninstall' },

    -- mason-nvim-dap is loaded when nvim-dap loads. Options are passed in there
    opts = {},
    config = function() end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'nvim-neotest/nvim-nio' },
    keys = {
      {
        '<leader>du',
        function()
          require('dapui').toggle {}
        end,
        desc = 'Dap UI',
      },
      {
        '<leader>de',
        function()
          require('dapui').eval()
        end,
        desc = 'Eval',
        mode = { 'n', 'v' },
      },
    },
    opts = {},
    config = function(_, opts)
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup(opts)
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close {}
      end
    end,
  },

  {
    'mfussenegger/nvim-dap',

    dependencies = {
      { 'rcarriga/nvim-dap-ui' },
      { 'leoluz/nvim-dap-go' },
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = {},
      },
      { 'folke/lazydev.nvim', opts = { library = { 'nvim-dap-ui' } } },
    },

    -- stylua: ignore
    keys = {
      { '<leader>dc', function() require('dap').continue() end, desc = '[D]ebug: Start/[C]ontinue' },
      { '<leader>dC', function() require('dap').run_to_cursor() end, desc = '[D]ebug: Run to [C]ursor' },
      { '<leader>di', function() require('dap').step_into() end, desc = '[D]ebug: Step [I]nto' },
      { '<leader>do', function() require('dap').step_over() end, desc = '[D]ebug: Step [O]ver' },
      { '<leader>dO', function() require('dap').step_out() end, desc = '[D]ebug: Step [O]ut' },
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = '[D]ebug Toggle [B]reakpoint' },
      { '<leader>dq', function() require('dap').terminate() end, desc = '[D]ebug: [Q]uit Session' },
      { '<leader>de', function() require('dapui').eval() end, desc = '[D]ebug [E]valuate' },
      {
        '<leader>dB',
        function()
          configure_dap().dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = '[D]ebug: Conditional [B]reakpoint',
      },
      -- stylua: enable
    },

    config = function()
      require('mason-nvim-dap').setup {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {},
      }
    end,
  },
}

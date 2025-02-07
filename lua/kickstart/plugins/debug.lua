return {
  'mfussenegger/nvim-dap',

  event = 'VeryLazy',

  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap-python',
    'leoluz/nvim-dap-go',
  },

  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'

    return {
      { '<leader>dc', dap.continue, desc = '[D]ebug: Start/[C]ontinue' },
      { '<leader>dC', dap.run_to_cursor, desc = '[D]ebug: Run to [C]ursor' },
      { '<leader>di', dap.step_into, desc = '[D]ebug: Step [I]nto' },
      { '<leader>do', dap.step_over, desc = '[D]ebug: Step [O]ver' },
      { '<leader>du', dap.step_out, desc = '[D]ebug: Step O[u]t' },
      { '<leader>db', dap.toggle_breakpoint, desc = '[D]ebug Toggle [B]reakpoint' },
      { '<leader>dq', dap.terminate, desc = '[D]ebug: [Q]uit Session' },
      {
        '<leader>dB',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = '[D]ebug: Conditional [B]reakpoint',
      },

      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      -- { '<leader>ds', dapui.toggle, desc = '[D]ebug See last session result.' },

      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- local dap_python = require 'dap-python'
    require('dap-python').setup 'python3'

    -- WARNING: Assumes the visual studio codelldb plugin is installed
    local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
    local codelldb_path = extension_path .. 'adapter/codelldb'
    local this_os = vim.uv.os_uname().sysname

    -- The path is different on Windows
    if this_os:find 'Windows' then
      codelldb_path = extension_path .. 'adapter\\codelldb.exe'
    end

    dap.adapters.codelldb = {
      type = 'executable',
      command = codelldb_path,
      name = 'lldb',
    }

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }

    -- C++ Debugger
    dap.configurations.cpp = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        MiMode = 'codelldb',
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
      },
    }
  end,
}

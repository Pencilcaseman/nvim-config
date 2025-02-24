local configure_dap_rust = function()
  local dap = require 'dap'

  dap.configurations.rust = {
    {
      name = 'Launch',
      type = 'codelldb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    },
  }

  vim.g.rustaceanvim = function()
    -- Update this path
    local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
    local codelldb_path = extension_path .. 'adapter/codelldb'
    local liblldb_path = extension_path .. 'lldb/lib/liblldb'
    local this_os = vim.uv.os_uname().sysname

    -- The path is different on Windows
    if this_os:find 'Windows' then
      codelldb_path = extension_path .. 'adapter\\codelldb.exe'
      liblldb_path = extension_path .. 'lldb\\bin\\liblldb.dll'
    else
      -- The liblldb extension is .so for Linux and .dylib for MacOS
      liblldb_path = liblldb_path .. (this_os == 'Linux' and '.so' or '.dylib')
    end

    local cfg = require 'rustaceanvim.config'
    return {
      dap = {
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    }
  end
end

local configure_dap_cpp = function()
  -- WARNING: Assumes the visual studio codelldb plugin is installed

  local dap = require 'dap'

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
end

local configure_dap_go = function()
  -- Install golang specific config
  require('dap-go').setup {
    delve = {
      -- On Windows delve must be run attached or it crashes.
      -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
      detached = vim.fn.has 'win32' == 0,
    },
  }
end

local configure_dap_python = function()
  require('dap-python').setup 'python3'
end

local configure_dapui = function()
  local dapui = require 'dapui'

  -- For more information, see |:help nvim-dap-ui|
  dapui.setup {
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
end

local dap_configured = false

local configure_dap = function()
  local dap = require 'dap'

  if not dap_configured then
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,

      handlers = {},

      ensure_installed = {
        'delve',
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    configure_dapui()
    configure_dap_rust()
    configure_dap_cpp()
    configure_dap_go()
    configure_dap_python()

    dap_configured = true
  end

  return dap
end

return {
  'mfussenegger/nvim-dap',

  dependencies = {
    { 'rcarriga/nvim-dap-ui', lazy = true },
    { 'nvim-neotest/nvim-nio', lazy = true },
    { 'williamboman/mason.nvim', lazy = true },
    { 'jay-babu/mason-nvim-dap.nvim', lazy = true },
    { 'mfussenegger/nvim-dap-python', lazy = true },
    { 'leoluz/nvim-dap-go', lazy = true },
  },

  -- stylua: ignore
  keys = {
    { '<leader>dc', function() configure_dap().continue() end, desc = '[D]ebug: Start/[C]ontinue' },
    { '<leader>dC', function() configure_dap().run_to_cursor() end, desc = '[D]ebug: Run to [C]ursor' },
    { '<leader>di', function() configure_dap().step_into() end, desc = '[D]ebug: Step [I]nto' },
    { '<leader>do', function() configure_dap().step_over() end, desc = '[D]ebug: Step [O]ver' },
    { '<leader>dO', function() configure_dap().step_out() end, desc = '[D]ebug: Step [O]ut' },
    { '<leader>db', function() configure_dap().toggle_breakpoint() end, desc = '[D]ebug Toggle [B]reakpoint' },
    { '<leader>dq', function() configure_dap().terminate() end, desc = '[D]ebug: [Q]uit Session' },
    {
      '<leader>dB',
      function()
        configure_dap().set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = '[D]ebug: Conditional [B]reakpoint',
    },
  },
  -- stylua: enable

  -- config = function()
  --   local dap = require 'dap'
  --   local dapui = require 'dapui'
  --
  --   require('mason-nvim-dap').setup {
  --     automatic_installation = true,
  --
  --     handlers = {},
  --
  --     ensure_installed = {
  --       'delve',
  --     },
  --   }
  --
  --   dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  --   dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  --   dap.listeners.before.event_exited['dapui_config'] = dapui.close
  --
  --   configure_dapui()
  --   configure_dap_rust()
  --   configure_dap_cpp()
  --   configure_dap_go()
  --   configure_dap_python()
  -- end,
}

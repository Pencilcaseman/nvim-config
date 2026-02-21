local add, later = PackMan.add, PackMan.later

later(function() add 'https://github.com/rcarriga/nvim-dap-ui' end )
later(function() add 'https://github.com/nvim-neotest/nvim-nio' end )
later(function() add 'https://github.com/jay-babu/mason-nvim-dap.nvim' end )
later(function() add 'https://github.com/theHamsta/nvim-dap-virtual-text' end )
later(function() add 'https://github.com/leoluz/nvim-dap-go' end )
later(function() add 'https://github.com/folke/lazydev.nvim' end )

later(function()
  add {
    src = 'https://github.com/mfussenegger/nvim-dap',
  }

  local dap = require 'dap'
  local dapui = require 'dapui'

  require('lazydev').setup {
    library = { 'nvim-dap-ui' },
  }

  require('nvim-dap-virtual-text').setup {}

  require('mason-nvim-dap').setup {
    automatic_installation = true,
    handlers = {},
    ensure_installed = {},
  }

  dapui.setup {}

  dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open {}
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close {}
  end
  dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close {}
  end

  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { desc = desc })
  end

  map('<leader>du', function()
    dapui.toggle {}
  end, 'Dap UI')
  map('<leader>de', function()
    dapui.eval()
  end, 'Eval', { 'n', 'v' })

  map('<leader>dc', function()
    dap.continue()
  end, '[D]ebug: Start/[C]ontinue')
  map('<leader>dC', function()
    dap.run_to_cursor()
  end, '[D]ebug: Run to [C]ursor')
  map('<leader>di', function()
    dap.step_into()
  end, '[D]ebug: Step [I]nto')
  map('<leader>do', function()
    dap.step_over()
  end, '[D]ebug: Step [O]ver')
  map('<leader>dO', function()
    dap.step_out()
  end, '[D]ebug: Step [O]ut')
  map('<leader>db', function()
    dap.toggle_breakpoint()
  end, '[D]ebug Toggle [B]reakpoint')
  map('<leader>dq', function()
    dap.terminate()
  end, '[D]ebug: [Q]uit Session')

  map('<leader>dB', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  end, '[D]ebug: Conditional [B]reakpoint')
end)

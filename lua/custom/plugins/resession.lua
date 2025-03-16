return {
  'stevearc/resession.nvim',

  event = 'VeryLazy',

  dependencies = {
    'romgrk/barbar.nvim',
  },

  opts = {
    extensions = {
      barbar = {},
    },
  },

  keys = function(_, keys)
    local resession = require 'resession'

    return {
      { '<leader>ws', resession.save, desc = '[W]orkspace: [S]ave Session' },
      { '<leader>wl', resession.load, desc = '[W]orkspace: [L]oad Session' },
      { '<leader>wd', resession.delete, desc = '[W]orkspace: [D]elete Session' },
      unpack(keys),
    }
  end,

  config = function(_, opts)
    -- vim.opt.sessionoptions:append 'globals'
    -- require('resession').add_hook('pre_save', function()
    --   vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
    -- end)

    local resession = require 'resession'
    resession.setup(opts)

    vim.api.nvim_create_autocmd('VimLeavePre', {
      callback = function()
        if vim.fn.argc(-1) == 0 then
          resession.save(vim.fn.getcwd(), { dir = 'dirsession', notify = false })
        end
      end,
    })
  end,
}

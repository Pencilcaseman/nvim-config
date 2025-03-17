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
    local resession = require 'resession'
    resession.setup(opts)

    vim.api.nvim_create_autocmd('VimLeavePre', {
      callback = function()
        local has_open_file = false
        for buf = 1, vim.fn.bufnr '$' do
          if vim.fn.buflisted(buf) == 1 then
            has_open_file = true
            break
          end
        end

        if vim.fn.argc(-1) == 0 and has_open_file then
          resession.save(vim.fn.getcwd(), { dir = 'dirsession', notify = false })
        end
      end,
    })
  end,
}

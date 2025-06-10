return {
  'MagicDuck/grug-far.nvim',

  opts = { headerMaxWidth = 80, transient = true },

  -- Load on key press
  keys = {
    {
      '<leader>dr',
      function()
        local grug = require 'grug-far'
        grug.open()
      end,
      mode = { 'n', 'v' },
      desc = '[D]ocument [R]eplace',
    },
  },

  config = function(_, opts)
    require('grug-far').setup(opts)
  end,
}

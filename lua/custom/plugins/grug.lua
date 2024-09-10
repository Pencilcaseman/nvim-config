return {
  'MagicDuck/grug-far.nvim',
  opts = { headerMaxWidth = 80, transient = true },
  cmd = 'GrugFar',
  keys = function(_, keys)
    return {
      {
        '<leader>dr',
        function()
          local grug = require 'grug-far'
          grug.open()
        end,
        mode = { 'n', 'v' },
        desc = '[D]ocument [R]eplace',
      },
      unpack(keys),
    }
  end,
  config = function(_, opts)
    require('grug-far').setup(opts)
  end,
}

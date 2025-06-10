return {
  'stevearc/overseer.nvim',
  keys = function(_, keys)
    return {
      { '<leader>ob', '<CMD>OverseerBuild<CR>', desc = '[O]verseer [B]uild' },
      { '<leader>oc', '<CMD>OverseerClose<CR>', desc = '[O]verseer [C]lose' },
      { '<leader>od', '<CMD>OverseerDeleteBundle<CR>', desc = '[O]verseer [D]elete Bundle' },
      { '<leader>ol', '<CMD>OverseerLoadBundle<CR>', desc = '[O]verseer [L]oad Bundle' },
      { '<leader>oo', '<CMD>OverseerOpen<CR>', desc = '[O]verseer [O]pen' },
      { '<leader>or', '<CMD>OverseerRun<CR>', desc = '[O]verseer [R]un' },
      { '<leader>os', '<CMD>OverseerSaveBundle<CR>', desc = '[O]verseer [S]ave Bundle' },
      { '<leader>ot', '<CMD>OverseerTaskAction<CR>', desc = '[O]verseer [T]ask Action' },
      { '<leader>ot', '<CMD>OverseerTaskAction<CR>', desc = '[O]verseer [T]ask Action' },

      unpack(keys),
    }
  end,
  opts = {},
  config = function(_, opts)
    require('overseer').setup(opts)
  end,
}

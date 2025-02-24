return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {
    need = 0,
  },

  -- stylua: ignore start
  keys = {
    { "<leader>wl", function() require("persistence").load({ last = true }) end, desc="[W]orkspace [L]oad" },
    { "<leader>wL", function() require("persistence").load() end, desc="[W]orkspace [L]oad" },
    { "<leader>wp", function() require("persistence").select() end, desc="[W]orkspace [P]ick" },
    { "<leader>wq", function() require("persistence").stop() end, desc="Do Not Save [W]orkspace" },
  },
  -- stylua: ignore stop
}

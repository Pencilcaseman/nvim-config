local add, later = MiniDeps.add, MiniDeps.later

later(function()
  -- {
  --   "folke/flash.nvim",
  --   event = "VeryLazy",
  --   ---@type Flash.Config
  --   opts = {},
  --   keys = {
  --     { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  --     { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  --     { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  --     { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --     { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  --   },
  -- }

  add 'folke/flash.nvim'

  require('flash').setup {}

  local map = function(modes, keys, cmd, opts)
    vim.keymap.set(modes, keys, cmd, opts)
  end

  map({ 'n', 'x', 'o' }, '<CR>', function()
    require('flash').jump()
  end, { desc = 'Flash' })

  map({ 'n', 'x', 'o' }, '<S-CR>', function()
    require('flash').treesitter()
  end, { desc = 'Flash' })
end)

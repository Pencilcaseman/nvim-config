local add, later = PackMan.add, PackMan.later

later(function()
  add 'https://github.com/folke/flash.nvim'

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

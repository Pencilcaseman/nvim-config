local add, later = PackMan.add, PackMan.later

later(function()
  add 'https://github.com/folke/flash.nvim'

  require('flash').setup {
    modes = {
      char = {
        char_actions = function(motion)
          return {
            [';'] = 'next',
            [','] = 'prev',
          }
        end,
      },
    },
  }

  local map = function(modes, keys, cmd, opts)
    vim.keymap.set(modes, keys, cmd, opts)
  end

  map({ 'n', 'x', 'o' }, 'gs', function()
    require('flash').jump()
  end, { desc = 'Flash' })

  map({ 'n', 'x', 'o' }, 'gS', function()
    require('flash').treesitter()
  end, { desc = 'Flash' })
end)

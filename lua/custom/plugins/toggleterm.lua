return {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  version = '*',
  opts = {--[[ things you want to change go here]]
    -- Shell is $HOME/.nix-profile/bin/fish
    shell = vim.env.HOME .. '/.nix-profile/bin/fish',
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
      return vim.o.lines * 0.4
    end,
  },
  keys = function(_, keys)
    local toggleterm = require 'toggleterm'
    return {
      {
        '<leader>ttf',
        function()
          toggleterm.toggle(nil, nil, nil, 'float')
        end,
        desc = '[T]oggle [T]erminal [F]loat',
      },
      -- {
      --   '<leader>ttb',
      --   function()
      --     toggleterm.toggle(nil, nil, nil, 'tab')
      --   end,
      --   desc = '[T]oggle [T]erminal [T]ab',
      -- },
      {
        '<leader>ttv',
        function()
          toggleterm.toggle(nil, nil, nil, 'vertical')
        end,
        desc = '[T]oggle [T]erminal [V]ertical',
      },
      {
        '<leader>tth',
        function()
          toggleterm.toggle(nil, nil, nil, 'horizontal')
        end,
        desc = '[T]oggle [T]erminal [H]orizontal',
      },
      unpack(keys),
    }
  end,
}

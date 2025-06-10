return {
  'akinsho/toggleterm.nvim',

  version = '*',

  opts = {
    shell = vim.env.SHELL,
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
    return {
      {
        '<leader>ttf',
        function()
          require('toggleterm').toggle(nil, nil, nil, 'float')
        end,
        desc = '[T]oggle [T]erminal [F]loat',
      },
      {
        '<leader>ttt',
        function()
          require('toggleterm').toggle(nil, nil, nil, 'tab')
        end,
        desc = '[T]oggle [T]erminal [T]ab',
      },
      {
        '<leader>ttv',
        function()
          require('toggleterm').toggle(nil, nil, nil, 'vertical')
        end,
        desc = '[T]oggle [T]erminal [V]ertical',
      },
      {
        '<leader>tth',
        function()
          require('toggleterm').toggle(nil, nil, nil, 'horizontal')
        end,
        desc = '[T]oggle [T]erminal [H]orizontal',
      },
      unpack(keys),
    }
  end,
}

return {
  'chentoast/marks.nvim',
  event = 'VeryLazy',

  opts = {
    default_mappings = false,
  },

  config = function(_, opts)
    require('marks').setup(opts)
  end,

  keys = {
    {
      'm',
      function()
        require('marks').set()
      end,
      desc = '[M]ark Set',
    },
    {
      'm,',
      function()
        require('marks').set_next()
      end,
      desc = '[M]ark Next',
    },
    {
      'm;',
      function()
        require('marks').toggle()
      end,
      desc = '[M]ark Toggle',
    },
    {
      'm:',
      function()
        require('marks').preview()
      end,
      desc = '[M]ark Preview',
    },
    {
      'dm',
      function()
        require('marks').delete()
      end,
      desc = '[D]elete [M]ark X',
    },
    {
      'dm;',
      function()
        require('marks').delete_line()
      end,
      desc = '[D]elete [M]arks on Line',
    },
    {
      'dm:',
      function()
        require('marks').delete_buf()
      end,
      desc = '[D]elete [M]arks in Buffer',
    },
  },
}

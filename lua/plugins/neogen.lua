return {
  'danymat/neogen',
  cmd = 'Neogen',

  -- stylua: ignore
  keys = {
    { "<leader>cgf", function() require('neogen').generate({ type = 'func' }) end, desc = "[C]ode [G]enerate [F]unction"},
    { "<leader>cgc", function() require('neogen').generate({ type = 'class' }) end, desc = "[C]ode [G]enerate [C]lass"},
    { "<leader>cgt", function() require('neogen').generate({ type = 'type' }) end, desc = "[C]ode [G]enerate [T]ype"},
  },

  opts = {
    languages = {
      python = {
        template = {
          annotation_convention = 'numpydoc',
        },
      },
    },
  },

  config = function(_, opts)
    require('neogen').setup(opts)
  end,
}

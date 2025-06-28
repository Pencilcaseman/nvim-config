return {
  'echasnovski/mini.nvim',
  event = 'VeryLazy',
  version = false,
  config = function()
    require('mini.ai').setup()
  end,
}

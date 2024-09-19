return {
  'saecki/crates.nvim',
  event = 'VeryLazy',
  config = function()
    require('crates').setup()
  end,
}

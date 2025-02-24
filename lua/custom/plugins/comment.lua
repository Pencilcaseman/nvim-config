return {
  'numToStr/Comment.nvim',
  keys = { 'gc', 'gb' }, -- All comment operations start with gc or gb
  config = function()
    require('Comment').setup()
  end,
}

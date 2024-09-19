return {
  'chomosuke/typst-preview.nvim',
  event = 'VeryLazy',
  build = function()
    require('typst-preview').update()
  end,
}

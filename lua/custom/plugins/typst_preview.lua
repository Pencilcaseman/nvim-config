return {
  'chomosuke/typst-preview.nvim',
  build = function()
    require('typst-preview').update()
  end,
}

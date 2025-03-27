return {
  'chomosuke/typst-preview.nvim',
  cmd = 'TypstPreview',
  build = function()
    require('typst-preview').update()
  end,
}

return {
  'jeangiraldoo/codedocs.nvim',
  event = 'VeryLazy',
  config = function()
    require('codedocs').setup {
      default_styles = { python = 'Google' },
    }
  end,
}

return {
  'toppair/peek.nvim',
  cmd = { 'PeekOpen', 'PeekClose' },
  build = 'deno task --quiet build:fast',
  config = function()
    require('peek').setup()
    -- Create user commands only when the plugin is loaded
    vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
    vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
  end,
}

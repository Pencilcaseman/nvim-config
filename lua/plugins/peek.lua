return {
  'toppair/peek.nvim',
  enabled = function()
    -- Peek requires deno to be installed
    return vim.fn.executable 'deno' == 1
  end,
  cmd = { 'PeekOpen', 'PeekClose' },
  build = 'deno task --quiet build:fast',
  config = function()
    require('peek').setup()
    -- Create user commands only when the plugin is loaded
    vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
    vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
  end,
}

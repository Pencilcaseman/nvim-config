return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = true,
  opts = {
    map_cr = true,
    ignored_next_char = '[%w%.]',
  },
}

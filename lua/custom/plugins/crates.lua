return {
  'saecki/crates.nvim',
  event = { 'BufRead Cargo.toml' },
  opts = {
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
  },
  config = function(_, opts)
    require('crates').setup(opts)
  end,
}

-- return {
--   require 'themes.material',
--   require 'themes.onedark',
-- }

return {
  'cpea2506/one_monokai.nvim',
  opts = {
    transparent = true,
  },
  config = function(_, opts)
    require('one_monokai').setup(opts)
  end,
}

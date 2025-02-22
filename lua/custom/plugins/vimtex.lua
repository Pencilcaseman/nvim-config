local utils = require 'utils'

-- Not a required plugin
if utils.is_minimal() then
  return {}
end

return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  init = function()
    vim.g.vimtex_view_method = 'skim'
  end,
  config = function()
    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_complete_enabled = 1
    vim.g.vimtex_matchparen_enabled = 1
    vim.g.vimtex_syntax_enabled = 1
    vim.g.vimtex_fold_enabled = 0
  end,
}

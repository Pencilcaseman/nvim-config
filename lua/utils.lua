local M = {}

M.is_minimal = function()
  -- If the environment variable $NVIM_MINIMAL is set, we want to launch Neovim
  -- with a minimal set of plugins so it opens faster.
  if os.getenv 'NVIM_MINIMAL' then
    return true
  end
  return false
end

return M

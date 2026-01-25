-- #############################################################################
-- Save the relative position of the cursor in the window when switching buffers
-- #############################################################################

local function should_save_view()
  return vim.bo.buftype == ''
end

vim.api.nvim_create_autocmd('BufWinLeave', {
  callback = function()
    if should_save_view() then
      ---@diagnostic disable-next-line: param-type-mismatch
      pcall(vim.cmd, 'silent! mkview')
    end
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    if should_save_view() then
      ---@diagnostic disable-next-line: param-type-mismatch
      pcall(vim.cmd, 'silent! loadview')
    end
  end,
})

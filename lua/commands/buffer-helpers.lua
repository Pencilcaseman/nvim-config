vim.api.nvim_create_user_command('CloseAllButCurrent', function()
  local current_buf = vim.fn.bufnr()
  local current_win = vim.fn.win_getid()
  local bufs = vim.fn.getbufinfo { buflisted = 1 }
  for _, buf in ipairs(bufs) do
    if buf.bufnr ~= current_buf then
      MiniBufremove.delete(buf.bufnr)
    end
  end
  vim.fn.win_gotoid(current_win)
end, {})

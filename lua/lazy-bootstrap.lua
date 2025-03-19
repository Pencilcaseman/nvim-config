-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local function lazy_file()
  local Event = require 'lazy.core.handler.event'
  local lazy_file_events = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }
  Event.mappings.LazyFile = { id = 'LazyFile', event = lazy_file_events }
  Event.mappings['User LazyFile'] = Event.mappings.LazyFile
end

lazy_file()

-- vim: ts=2 sts=2 sw=2 et

if vim.env.PROF then
  local snacks = vim.fn.stdpath 'data' .. '/lazy/snacks.nvim'
  vim.opt.rtp:append(snacks)
  require('snacks.profiler').startup {
    startup = {
      event = 'VimEnter',
    },
  }
end

vim.opt.showtabline = 2 -- Always reserve space for the tabline (barbar)
vim.opt.winbar = 'NeoVim > Bread > Crumbs' -- Preload space for barbecue

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true

vim.t.have_nerd_font = true

require 'options'
require 'keymaps'
require 'lazy-bootstrap'
require 'lazy-plugins'
require 'custom-commands'

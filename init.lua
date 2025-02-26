if vim.loader then
  vim.loader.enable()
end

if vim.env.PROF then
  local snacks = vim.fn.stdpath 'data' .. '/lazy/snacks.nvim'
  vim.opt.rtp:append(snacks)
  require('snacks.profiler').startup {
    startup = {
      event = 'VimEnter',
    },
  }
end

-- Set this to false if you do not have a NerdFont installed
vim.g.have_nerd_font = true

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable spell checking
vim.opt.spell = true
vim.opt.spelllang = 'en'

vim.opt.showtabline = 2 -- Always reserve space for the tabline (barbar)
vim.opt.winbar = 'NeoVim > Bread > Crumbs' -- Preload space for barbecue

vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true

require 'options'
require 'keymaps'
require 'lazy-bootstrap'
require 'lazy-plugins'
require 'custom-commands'

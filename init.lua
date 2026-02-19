if vim.loader then
  vim.loader.enable()
end

vim.g.have_nerd_font = true

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable spell checking
vim.opt.spell = true
vim.opt.spelllang = 'en'

vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.modeline = true
vim.opt.modelines = 3

vim.opt.showtabline = 2 -- Always reserve space for the tabline (barbar)
vim.opt.winbar = 'NeoVim > Bread > Crumbs' -- Preload space for barbecue

-- Inherit environment from original shell
vim.opt.shellcmdflag = '-lc'

require 'options'
require 'keymaps'
require 'bootstrap-mini-deps'
require 'plugins'
require 'custom-commands'

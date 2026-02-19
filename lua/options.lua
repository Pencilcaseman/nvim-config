-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.conceallevel = 0

-- Column limit at 80 -- highlight at 81
vim.opt.colorcolumn = '81'
vim.opt.textwidth = 80

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Break on words instead of characters
vim.opt.linebreak = true

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable signcolumn and add space for two items (diff and marks)
vim.opt.signcolumn = 'yes:2'
-- vim.opt.signcolumn = 'auto:3'

-- Decrease update time
vim.opt.updatetime = 250

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live
vim.opt.inccommand = 'split'

vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Disable folding on startup
vim.wo.foldlevel = 100

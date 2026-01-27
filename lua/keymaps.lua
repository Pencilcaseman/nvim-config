-- [[ Basic Keymaps ]]

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use OPTION+SHIFT+<hjkl> to switch between windows
vim.keymap.set('n', '<A-H>', '<C-W>h', { desc = 'Move focus to the left widnow' })
vim.keymap.set('n', '<A-J>', '<C-W>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<A-K>', '<C-W>k', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<A-L>', '<C-W>l', { desc = 'Move focus to the right window' })

vim.api.nvim_set_keymap('n', 'Ó', '<C-w>h', { noremap = true, silent = true, desc = 'Move focus to the left widnow' })
vim.api.nvim_set_keymap('n', 'Ô', '<C-w>j', { noremap = true, silent = true, desc = 'Move focus to the lower window' })
vim.api.nvim_set_keymap('n', '', '<C-w>k', { noremap = true, silent = true, desc = 'Move focus to the upper window' })
vim.api.nvim_set_keymap('n', 'Ò', '<C-w>l', { noremap = true, silent = true, desc = 'Move focus to the right window' })

-- Swap 0 and ^
vim.keymap.set('n', '0', '^', { desc = 'Go to the first non-blank character' })
vim.keymap.set('n', '^', '0', { desc = 'Go to the start of the line' })

-- -- Highlight when yanking (copying) text
-- --  Try it with `yap` in normal mode
-- --  See `:help vim.highlight.on_yank()`
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   desc = 'Highlight when yanking (copying) text',
--   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
--   callback = function()
--     vim.highlight.on_yank()
--   end,
-- })

-- Space d d to open diagnostic float
vim.keymap.set('n', '<leader>dd', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = '[D]ocument [D]iagnostics' })

-- Space f o to open the current working directory in the MacOS file explorer
if vim.fn.has 'mac' then
  vim.keymap.set('n', '<leader>fo', ':silent ! open .<CR>', { desc = '[F]ilesystem [O]pen', silent = true, noremap = true })
end

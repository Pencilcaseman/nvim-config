-- [[ Basic Keymaps ]]

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use OPTION+SHIFT+<hjkl> to switch between windows
vim.keymap.set('n', '<A-H>', '<C-W>h', { desc = 'Move focus to the left widnow' })
vim.keymap.set('n', '<A-J>', '<C-W>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<A-K>', '<C-W>k', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<A-L>', '<C-W>l', { desc = 'Move focus to the right window' })

-- Swap 0 and ^
vim.keymap.set('n', '0', '^', { desc = 'Go to the first non-blank character' })
vim.keymap.set('n', '^', '0', { desc = 'Go to the start of the line' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Space d d to open diagnostic float
vim.keymap.set('n', '<space>dd', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = '[D]ocument [D]iagnostics' })

-- vim: ts=2 sts=2 sw=2 et

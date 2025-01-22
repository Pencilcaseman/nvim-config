-- If we open [insert file type here], set textwidth to 80

vim.api.nvim_create_augroup('SetTextWidth', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'SetTextWidth',
  pattern = { 'tex', 'markdown', 'text', 'typst' },
  command = 'set textwidth=80',
})

-- If we open a code file, set textwidth to 999999

vim.api.nvim_create_autocmd('FileType', {
  group = 'SetTextWidth',
  pattern = {
    'c',
    'cpp',
    'go',
    'java',
    'javascript',
    'lua',
    'python',
    'rust',
    'sh',
    'sql',
    'vim',
    'yaml',
    'toml',
    'json',
    'html',
    'css',
  },
  command = 'set textwidth=999999',
})

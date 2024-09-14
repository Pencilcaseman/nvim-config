return {
  'gbprod/yanky.nvim',
  opts = {},
  config = function(_, opts)
    require('yanky').setup(opts)

    local keymap = vim.keymap.set

    keymap({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
    keymap({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
    keymap({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
    keymap({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

    keymap('n', '<c-p>', '<Plug>(YankyPreviousEntry)')
    keymap('n', '<c-n>', '<Plug>(YankyNextEntry)')

    keymap('n', ']p', '<Plug>(YankyPutIndentAfterLinewise)')
    keymap('n', '[p', '<Plug>(YankyPutIndentBeforeLinewise)')
    keymap('n', ']P', '<Plug>(YankyPutIndentAfterLinewise)')
    keymap('n', '[P', '<Plug>(YankyPutIndentBeforeLinewise)')

    keymap('n', '>p', '<Plug>(YankyPutIndentAfterShiftRight)')
    keymap('n', '<p', '<Plug>(YankyPutIndentAfterShiftLeft)')
    keymap('n', '>P', '<Plug>(YankyPutIndentBeforeShiftRight)')
    keymap('n', '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)')

    keymap('n', '=p', '<Plug>(YankyPutAfterFilter)')
    keymap('n', '=P', '<Plug>(YankyPutBeforeFilter)')
  end,
}

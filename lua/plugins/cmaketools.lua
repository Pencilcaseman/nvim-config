return {
  'Civitasv/cmake-tools.nvim',
  event = 'VeryLazy',

  cond = function()
    return vim.fn.filereadable 'CMakeLists.txt' == 1
  end,

  dependencies = {
    'stevearc/overseer.nvim',
    'nvim-lua/plenary.nvim',
  },
  opts = {},
}

return {
  'Civitasv/cmake-tools.nvim',
  cmd = 'CMake', -- Only load when the 'CMake' command is run
  dependencies = {
    'stevearc/overseer.nvim',
    'nvim-lua/plenary.nvim',
  },
  opts = {},
}

return {
  'ms-jpq/chadtree',
  branch = 'chad',
  build = 'python3 -m chadtree deps',

  keys = {
    { '<leader>e', '<cmd>CHADopen<cr>', desc = 'File [E]xplorer' },
  },
}

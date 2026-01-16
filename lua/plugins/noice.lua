return {
  'folke/noice.nvim',

  opts = {
    cmdline = { enabled = true },

    statusline = { enabled = false },
    progress = { enabled = false },
    lsp = { progress = { enabled = false } },
    routes = { enabled = false },

    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },
  },

  config = function(_, opts)
    require('noice').setup(opts)
    vim.o.cmdheight = 0
  end,
}

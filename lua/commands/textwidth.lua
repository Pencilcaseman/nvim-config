vim.opt.textwidth = 80

vim.api.nvim_create_augroup('ProseAutoWrap', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = 'ProseAutoWrap',
  pattern = { 'tex', 'markdown', 'text', 'typst' },
  callback = function()
    vim.schedule(function()
      vim.opt_local.formatoptions:append 't'
      vim.opt_local.formatoptions:append 'c'
      vim.opt_local.formatoptions:append 'l'
    end)
  end,
})

local disabled_built_ins = {
  -- '2html_plugin',
  -- 'tohtml',

  -- 'gzip',
  -- 'tar',
  -- 'tarPlugin',
  -- 'zip',
  -- 'zipPlugin',

  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',

  -- 'logipat',
  -- 'matchit',

  -- 'rplugin',
  -- 'rrhelper',

  'syntax',
  -- 'ftplugin',

  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',

  -- 'spellfile_plugin',
  'tutor',
  'synmenu',
  'optwin',
  -- 'compiler',
  -- 'bugreport',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

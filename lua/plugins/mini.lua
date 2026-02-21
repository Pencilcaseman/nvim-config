local add, now, later = PackMan.add, PackMan.now, PackMan.later

local function map(keys, fn, desc)
  vim.keymap.set('n', keys, fn, { buffer = buf, desc = desc })
end

local nmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc })
end

now(function()
  add 'https://github.com/nvim-mini/mini.nvim'
end)

-- stylua: ignore start
now(function() require('mini.starter').setup() end)

later(function() require('mini.ai').setup() end)
later(function() require('mini.align').setup() end)
later(function() require('mini.bracketed').setup() end)
later(function() require('mini.bufremove').setup() end)
later(function() require('mini.colors').setup() end)
later(function() require('mini.comment').setup() end)
later(function() require('mini.extra').setup() end)
later(function() require('mini.git').setup() end)
later(function() require('mini.keymap').setup() end)
later(function() require('mini.misc').setup() end)
later(function() require('mini.notify').setup() end)
later(function() require('mini.statusline').setup() end)
later(function() require('mini.surround').setup() end)
later(function() require('mini.trailspace').setup() end)
later(function() require('mini.visits').setup() end)

-- stylua: ignore end

now(function()
  require('mini.sessions').setup {
    force = { read = false, write = true, delete = true },
  }
end)

later(function()
  require('mini.basics').setup {
    options = {
      basic = true,
      extra_ui = true,
      win_borders = 'double', -- single, double, auto
    },

    mappings = {
      basic = true,
      option_toggle_prefix = [[\]],
      windows = true,
    },

    autocommands = {
      basic = true,
      relnum_in_visual_mode = false,
    },
  }
end)

later(function()
  require('mini.diff').setup {
    view = {
      style = 'sign', -- 'sign' or 'number'
    },
  }

  -- -- Change colors slightly to make them stand out more
  vim.cmd [[ highlight MiniDiffSignAdd guifg=#67cc20 ]]
  vim.cmd [[ highlight MiniDiffSignChange guifg=#46a1f0 ]]
  vim.cmd [[ highlight MiniDiffSignDelete guifg=#ff5c43 ]]
end)

later(function()
  require('mini.tabline').setup {}

  map('H', '<CMD>bprev<CR>', 'Previous Buffer')
  map('L', '<CMD>bnext<CR>', 'Next Buffer')
  map('<leader>bd', MiniBufremove.delete, 'Delete Buffer')
  map('<leader>bD', '<CMD>CloseAllButCurrent<CR>', 'Delete Buffer')
end)

later(function()
  require('mini.pairs').setup {
    modes = { command = true },
  }
end)

later(function()
  require('mini.cmdline').setup {
    autocomplete = {
      enable = false,
    },

    autopeek = {
      n_context = 8,
    },
  }
end)

later(function()
  require('mini.files').setup {
    windows = {
      preview = true,
      width_preview = 60,
    },
  }

  -- File explorer
  map('<leader>e', function()
    if MiniFiles.get_explorer_state() then
      MiniFiles.close()
    else
      MiniFiles.open()
    end
  end, 'File [E]xplorer')

  map('<leader>E', function()
    if MiniFiles.get_explorer_state() then
      MiniFiles.close()
    else
      MiniFiles.open(vim.api.nvim_buf_get_name(0))
    end
  end, 'File [E]xplorer')
end)

later(function()
  local miniclue = require 'mini.clue'

  local leader_group_clues = {
    { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
    { mode = 'n', keys = '<Leader>c', desc = '+Code' },
    { mode = 'n', keys = '<Leader>d', desc = '+Debug' },
    { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
    { mode = 'n', keys = '<Leader>o', desc = '+Overseer' },
    { mode = 'n', keys = '<Leader>s', desc = '+Search' },

    { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
    { mode = 'n', keys = '<Leader>c', desc = '+Code' },
    { mode = 'n', keys = '<Leader>d', desc = '+Debug' },
    { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
    { mode = 'n', keys = '<Leader>o', desc = '+Overseer' },
    { mode = 'n', keys = '<Leader>s', desc = '+Search' },

    -- { mode = 'n', keys = 'm', desc = '+Marks' },
  }

  miniclue.setup {
    clues = {
      leader_group_clues,
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.square_brackets(),
      miniclue.gen_clues.windows { submode_resize = true },
      miniclue.gen_clues.z(),
    },

    triggers = {
      { mode = { 'n', 'x' }, keys = '<Leader>' }, -- Leader triggers
      { mode = 'n', keys = '\\' }, -- mini.basics
      { mode = { 'n', 'x' }, keys = '[' }, -- mini.bracketed
      { mode = { 'n', 'x' }, keys = ']' },
      { mode = 'i', keys = '<C-x>' }, -- Built-in completion
      { mode = { 'n', 'x' }, keys = 'g' }, -- `g` key
      { mode = { 'n', 'x' }, keys = "'" }, -- Marks
      { mode = { 'n', 'x' }, keys = '`' },
      { mode = { 'n', 'x' }, keys = '"' }, -- Registers
      { mode = { 'i', 'c' }, keys = '<C-r>' },
      { mode = 'n', keys = '<C-w>' }, -- Window commands
      { mode = { 'n', 'x' }, keys = 's' }, -- `s` key (mini.surround, etc.)
      { mode = { 'n', 'x' }, keys = 'z' }, -- `z` key
      { mode = { 'x', 'o' }, keys = 'a' }, -- Text objects
      { mode = { 'x', 'o' }, keys = 'i' },
      { mode = { 'x', 'o' }, keys = 'l' },
      { mode = { 'x', 'o' }, keys = 'r' },
    },

    window = {
      delay = 0,
    },
  }
end)

later(function()
  local hipatterns = require 'mini.hipatterns'
  local hi_words = MiniExtra.gen_highlighter.words
  hipatterns.setup {
    highlighters = {
      fixme = hi_words({ 'FIXME', 'Fixme', 'fixme' }, 'MiniHipatternsFixme'),
      panic = hi_words({ 'PANIC', 'Panic', 'panic' }, 'MiniHipatternsFixme'),
      hack = hi_words({ 'HACK', 'Hack', 'hack' }, 'MiniHipatternsHack'),
      todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
      note = hi_words({ 'NOTE', 'Note', 'note' }, 'MiniHipatternsNote'),

      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  }
end)

later(function()
  require('mini.pick').setup {
    options = {
      content_from_bottom = true,
      use_cache = true,
    },
  }
end)

local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
local git_log_buf_cmd = git_log_cmd .. ' --follow -- %'

local function session_action(action)
  return function()
    local mini_sessions = require 'mini.sessions'

    vim.ui.input({ prompt = 'Session Name: ' }, function(name)
      -- Cancel if user hits Esc or enters nothing
      if name == nil then
        return
      end

      if name == '' then
        name = nil
      end

      if action == 'write' then
        mini_sessions.write(name)
      elseif action == 'delete' then
        mini_sessions.delete(name)
      end
    end)
  end
end

-- stylua: ignore start
nmap_leader('s/', '<Cmd>Pick history scope="/"<CR>',            '"/" history')
nmap_leader('s:', '<Cmd>Pick history scope=":"<CR>',            '":" history')
nmap_leader('sa', '<Cmd>Pick git_hunks scope="staged"<CR>',     'Added hunks (all)')
nmap_leader('sb', '<Cmd>Pick buffers<CR>',                      'Buffers')
nmap_leader('sc', '<Cmd>Pick git_commits<CR>',                  'Commits (all)')
nmap_leader('sC', '<Cmd>Pick git_commits path="%"<CR>',         'Commits (buf)')
nmap_leader('sd', '<Cmd>Pick diagnostic scope="all"<CR>',       'Diagnostic workspace')
nmap_leader('sD', '<Cmd>Pick diagnostic scope="current"<CR>',   'Diagnostic buffer')
nmap_leader('sf', '<Cmd>Pick files<CR>',                        'Files')
nmap_leader('sg', '<Cmd>Pick grep_live<CR>',                    'Grep live')
nmap_leader('sG', '<Cmd>Pick grep pattern="<cword>"<CR>',       'Grep current word')
nmap_leader('sh', '<Cmd>Pick help<CR>',                         'Help tags')
nmap_leader('sH', '<Cmd>Pick hl_groups<CR>',                    'Highlight groups')
nmap_leader('sl', '<Cmd>Pick buf_lines scope="all"<CR>',        'Lines (all)')
nmap_leader('sL', '<Cmd>Pick buf_lines scope="current"<CR>',    'Lines (buf)')
nmap_leader('sm', '<Cmd>Pick git_hunks<CR>',                    'Modified hunks (all)')
nmap_leader('sM', '<Cmd>Pick git_hunks path="%"<CR>',           'Modified hunks (buf)')
nmap_leader('sr', '<Cmd>Pick resume<CR>',                       'Resume')
nmap_leader('sR', '<Cmd>Pick lsp scope="references"<CR>',       'References (LSP)')
nmap_leader('ss', '<Cmd>Pick lsp scope="document_symbol"<CR>',  'Symbols document')
nmap_leader('sv', '<Cmd>Pick visit_paths cwd=""<CR>',           'Visit paths (all)')
nmap_leader('sV', '<Cmd>Pick visit_paths<CR>',                  'Visit paths (cwd)')

nmap_leader('ga', '<Cmd>Git diff --cached<CR>',             'Added diff')
nmap_leader('gA', '<Cmd>Git diff --cached -- %<CR>',        'Added diff buffer')
nmap_leader('gc', '<Cmd>Git commit<CR>',                    'Commit')
nmap_leader('gC', '<Cmd>Git commit --amend<CR>',            'Commit amend')
nmap_leader('gd', '<Cmd>Git diff<CR>',                      'Diff')
nmap_leader('gD', '<Cmd>Git diff -- %<CR>',                 'Diff buffer')
nmap_leader('gl', '<Cmd>' .. git_log_cmd .. '<CR>',         'Log')
nmap_leader('gL', '<Cmd>' .. git_log_buf_cmd .. '<CR>',     'Log buffer')
nmap_leader('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>', 'Toggle overlay')
nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>',  'Show at cursor')

nmap_leader('xs', '<Cmd>lua MiniGit.show_at_cursor()<CR>',  'Show at selection')

nmap_leader('msd', session_action("delete"),  'Delete Session')
nmap_leader('msw', session_action("write"),   'Write Session')
-- stylua: ignore end

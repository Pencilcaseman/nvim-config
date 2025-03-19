return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,

  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },

    dashboard = {
      enabled = true,

      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          {
            icon = ' ',
            key = 's',
            desc = 'Restore Session',
            action = function()
              require('resession').load(vim.fn.getcwd(), {
                dir = 'dirsession',
                silence_errors = true,
              })
            end,
          },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = '', key = 'm', desc = 'Mason', action = ':Mason' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },

      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        {
          pane = 2,
          icon = ' ',
          title = 'Git Status',
          section = 'terminal',
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = 'git status --short --branch --renames',
          height = 10,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = 'startup' },
      },
    },

    explorer = { enabled = true },

    indent = {
      enabled = true,
      hl = 'SnacksIndent',
      animate = {
        enabled = false,
      },
    },

    picker = { enabled = true },

    profiler = { enabled = true },

    notifier = { enabled = true },

    quickfile = { enabled = true },

    rename = { enabled = true },
  },

  config = function(_, opts)
    require('snacks').setup(opts)
  end,

  keys = {
    -- Top Pickers & Explorer
    {
      '<leader>e',
      function()
        Snacks.explorer.open()
      end,
      desc = 'File [E]xplorer',
    },

    {
      '<leader>E',
      function()
        Snacks.explorer.reveal()
      end,
      desc = 'File [E]xplorer',
    },

    -- stylua: ignore start

    -- Top Pickers & Explorer
    { "<leader>sf", function() Snacks.picker.smart() end, desc = "Smart [S]earch [F]iles" },
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Search Buffers" },
    -- { "<leader>/", function() Snacks.picker.grep() end, desc = "Search Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Search Command History" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Search Notification History" },
    { "<leader>sp", function() Snacks.picker.projects() end, desc = "[S]earch [P]rojects" },
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "[S]earch Registers" },

    -- git
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },

    -- find
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },

    -- Grep
    { "<leader>/", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "[S]earch [G]rep" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

    -- search
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "[S]earch [A]utocmds" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "[S]earch [H]elp" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "[S]earch [H]ighlights" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "[S]earch [I]cons" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]eymaps" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "[S]earch [M]arks" },
    { "<leader>sp", function() Snacks.picker.lazy() end, desc = "[S]earch [P]lugin for Spec" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "[S]earch [Q]uickfix List" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "[S]earch [U]ndo" },
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "[S]earch [C]olorschemes" },

    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    -- stylua: ignore end
  },
}

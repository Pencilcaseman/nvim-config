local utils = require 'utils'

return {}

-- -- Not a required plugin
-- if utils.is_minimal() then
--   return {}
-- end

-- return {
--   'github/copilot.vim',
--   event = 'VeryLazy',
--   opts = {},
--   config = function()
--     vim.cmd [[
--       Copilot setup
--     ]]
--   end,
-- }

-- return {
--   'github/copilot.vim',
--   event = 'VeryLazy',
--   opts = {},
--   config = function()
--     vim.defer_fn(function()
--       vim.cmd [[
--         Copilot setup
--       ]]
--     end, 0) -- Executes asynchronously with a slight delay
--   end,
-- }

-- return {
--   'zbirenbaum/copilot.lua',
--   cmd = 'Copilot',
--   event = 'InsertEnter',
--   opts = {
--     suggestion = {
--       enabled = true,
--       auto_trigger = true,
--       hide_during_completion = true,
--       debounce = 75,
--       keymap = {
--         accept = '<S-TAB>',
--         accept_word = false,
--         accept_line = false,
--         next = '<M-]>',
--         prev = '<M-[>',
--         -- dismiss = '<ESC>',
--       },
--     },
--   },
--   config = function(_, opts)
--     require('copilot').setup(opts)
--   end,
-- }

-- return {
--   'supermaven-inc/supermaven-nvim',
--   -- commit = '074a83a74ad8a7b6f605df83e2583775aaeb4cfc',
--   event = 'VeryLazy',
--   opts = {
--     keymaps = {
--       -- Accept completions on SHIFT+TAB
--       accept_suggestion = '<S-TAB>',
--     },
--   },
--   config = function(_, opts)
--     require('supermaven-nvim').setup(opts)
--   end,
-- }

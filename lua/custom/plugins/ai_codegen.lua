return {
  'supermaven-inc/supermaven-nvim',
  commit = '074a83a74ad8a7b6f605df83e2583775aaeb4cfc',
  event = 'VeryLazy',
  opts = {
    keymaps = {
      -- Accept completions on SHIFT+TAB
      accept_suggestion = '<S-TAB>',
    },
  },
  config = function(_, opts)
    require('supermaven-nvim').setup(opts)
  end,
}

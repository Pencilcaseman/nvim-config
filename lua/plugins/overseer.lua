local add, later = PackMan.add, PackMan.later

later(function()
  add 'https://github.com/stevearc/overseer.nvim'
  require('overseer').setup {}

  local nmap_leader = function(suffix, rhs, desc)
    vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc })
  end

  nmap_leader('ob', '<CMD>OverseerBuild<CR>', '[O]verseer [B]uild')
  nmap_leader('oc', '<CMD>OverseerClose<CR>', '[O]verseer [C]lose')
  nmap_leader('od', '<CMD>OverseerDeleteBundle<CR>', '[O]verseer [D]elete Bundle')
  nmap_leader('ol', '<CMD>OverseerLoadBundle<CR>', '[O]verseer [L]oad Bundle')
  nmap_leader('oo', '<CMD>OverseerOpen<CR>', '[O]verseer [O]pen')
  nmap_leader('or', '<CMD>OverseerRun<CR>', '[O]verseer [R]un')
  nmap_leader('os', '<CMD>OverseerSaveBundle<CR>', '[O]verseer [S]ave Bundle')
  nmap_leader('ot', '<CMD>OverseerTaskAction<CR>', '[O]verseer [T]ask Action')
  nmap_leader('ot', '<CMD>OverseerTaskAction<CR>', '[O]verseer [T]ask Action')
end)

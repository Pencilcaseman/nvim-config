local add, later = MiniDeps.add, MiniDeps.later
local now_if_args = _G.Config.now_if_args

later(function()
    add({
        source = 'utilyre/barbecue.nvim',
        depends = {
            'SmiteshP/nvim-navic',
        }
    })

    require('barbecue').setup({})
end)

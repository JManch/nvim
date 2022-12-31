return {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    config = function()
        local colors = require("ayu.colors")
        colors.generate(true)
        require("ayu").setup({
            mirage = true,
            overrides = function()
                return { Comment = { fg = colors.comment } }
            end,
        })
        vim.cmd("colorscheme ayu-mirage")
        require("core.utils").set_highlights()
    end,
}

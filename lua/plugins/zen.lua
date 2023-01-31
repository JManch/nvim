return {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
        window = {
            backdrop = "1",
        },
        plugins = {
            twilight = { enabled = false }
        },
        on_open = function()
            require("lualine").hide()
            vim.o.statusline = " "
        end,
        on_close = function()
            require("lualine").hide({ unhide = true })
        end
    },
    keys = {
        { "<LEADER>z", "<CMD>ZenMode<CR>", desc = "Toggle zen mode" }
    }
}

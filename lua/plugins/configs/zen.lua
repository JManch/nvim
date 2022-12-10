local ok, zen = pcall(require, "zen-mode")

if not ok then
    return
end

local cmdheight

local map = require("core.mappings").map

map("n", "<LEADER>z", "<CMD>ZenMode<CR>", "Toggle zen mode")

local options = {
    window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
    },
    plugins = {
        gitsigns = { enabled = true },
    },
    on_open = function()
        cmdheight = vim.o.cmdheight
        vim.o.cmdheight = 1
    end,
    on_close = function()
        vim.o.cmdheight = cmdheight
    end,
}

zen.setup(options)

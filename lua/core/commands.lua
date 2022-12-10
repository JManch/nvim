local api = vim.api
local g = vim.g
local utils = require("core.utils")

local set_format_options = api.nvim_create_augroup("SetFormatOptions", {})
api.nvim_create_autocmd("FileType", {
    group = set_format_options,
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove("o")
    end,
})

local set_highlights = api.nvim_create_augroup("SetHighlights", {})
api.nvim_create_autocmd("ColorScheme", {
    group = set_highlights,
    pattern = "*",
    callback = utils.set_highlights,
})

local yank_highlight = api.nvim_create_augroup("YankHighlight", {})
api.nvim_create_autocmd("TextYankPost", {
    group = yank_highlight,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
    end,
})

api.nvim_create_user_command("ToggleAutoWrap", function()
    utils.toggle_local_opt("formatoptions", "t")
end, {})

api.nvim_create_user_command("ToggleCommentAutoWrap", function()
    utils.toggle_local_opt("formatoptions", "c")
end, {})

api.nvim_create_user_command("ToggleParagraphAutoFormat", function()
    utils.toggle_local_opt("formatoptions", "a")
end, {})

api.nvim_create_user_command("ToggleWinbar", function()
    utils.toggle_o("winbar", g.custom_winbar, "")
end, {})

api.nvim_create_user_command("ToggleColorcolumn", function()
    utils.toggle_wo("colorcolumn", "80", "")
end, {})

api.nvim_create_user_command("ToggleCMD", function()
    utils.toggle_o("cmdheight", 1, 0)
end, {})

api.nvim_create_user_command("ToggleVirtualText", function()
    vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, {})

local M = {
    "JManch/alpha-nvim",
	lazy = false,
}

local function button(sc, txt, keybind)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 4,
        width = 25,
        align_shortcut = "right",
        hl = "CmpItemMenu",
        hl_shortcut = "CmpItemMenu",
    }

    if keybind then
        opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
        vim.api.nvim_feedkeys(key, "normal", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local header = {
    type = "text",
    val = {
        "       __           __               ",
        "      / /___  _____/ /_  __  ______ _",
        " __  / / __ \\/ ___/ __ \\/ / / / __ `/",
        "/ /_/ / /_/ (__  ) / / / /_/ / /_/ / ",
        "\\____/\\____/____/_/ /_/\\__,_/\\__,_/  ",
    },
    opts = {
        position = "center",
        hl = "GitSignsChange",
    },
}

local total_plugins = 0

local plugin_count = {
    type = "text",
    val = "  " .. total_plugins .. " plugins installed",
    opts = {
        position = "center",
        hl = "CmpItemMenu",
    },
}

local buttons = {
    type = "group",
    val = {
        button("e", "   New file", ":ene <BAR> startinsert<CR>"),
        button("f", "   Find file", ":Telescope find_files<CR>"),
        button("d", "   Browse files", ":Telescope file_browser<CR>"),
        button("w", "   Load workspace", ":Telescope workspaces theme=dropdown previewer=false<CR>"),
        button("l", "   Toggle theme", ":SunsetToggle<CR>"),
        button("q", "   Quit", ":qa<CR>"),
    },
    opts = {
        position = "center",
        spacing = 1,
    },
}

local marginTopPercent = 0.25
local winheight = vim.fn.winheight(0)
local headerPadding = vim.fn.max({ 2, vim.fn.floor(winheight * marginTopPercent) })

local options = {
    layout = {
        { type = "padding", val = 8 },
        header,
        { type = "padding", val = 2 },
        buttons,
        { type = "padding", val = 1 },
        plugin_count,
        { type = "padding", val = winheight - headerPadding - 3 },
    },
    opts = {
        margin = 0,
    },
}

M.config = function()
    local group = vim.api.nvim_create_augroup("Alpha", {})
    -- Hide cursor when Alpha is opened
    vim.api.nvim_create_autocmd({ "User" }, {
        group = group,
        pattern = "AlphaReady",
        callback = function()
            if not vim.tbl_contains(vim.opt.guicursor:get(), "a:NoCursor") then
                vim.opt.guicursor:append("a:NoCursor")
                vim.api.nvim_create_autocmd("BufLeave", {
                    pattern = "<buffer>",
                    callback = function()
                        vim.opt.guicursor:remove("a:NoCursor")
                        return true
                    end,
                })
            end
        end,
    })

    -- Hide cursor when toggling between Alpha and other buffers
    vim.api.nvim_create_autocmd("BufEnter", {
        group = group,
        callback = function()
            if vim.bo.filetype ~= "alpha" then
                return
            end
            if not vim.tbl_contains(vim.opt.guicursor:get(), "a:NoCursor") then
                vim.opt.guicursor:append("a:NoCursor")
                vim.api.nvim_create_autocmd("BufLeave", {
                    pattern = "<buffer>",
                    callback = function()
                        vim.opt.guicursor:remove("a:NoCursor")
                        return true
                    end,
                })
            end
        end,
    })

    require("alpha").setup(options)
end

return M

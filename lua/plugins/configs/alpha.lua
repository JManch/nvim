local ok, alpha = pcall(require, "alpha")

if not ok then
    return
end

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

local total_plugins = #vim.tbl_keys(packer_plugins)

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

alpha.setup(options)

local group = vim.api.nvim_create_augroup("Alpha", {})
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "alpha",
    callback = function()
        if vim.o.winbar ~= "" then
            require("core.utils").toggle_o("winbar", vim.g.custom_winbar, "")
            vim.api.nvim_create_autocmd("BufUnload", {
                pattern = "<buffer>",
                callback = function()
                    if vim.o.winbar == "" then
                        require("core.utils").toggle_o("winbar", vim.g.custom_winbar, "")
                    end
                end,
            })
        end
    end,
})

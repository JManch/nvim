local ok, lualine = pcall(require, "lualine")

if not ok then
    return
end

local statusline_tab = function()
    local tab_count = vim.fn.tabpagenr("$")
    if tab_count ~= 1 then
        return vim.fn.tabpagenr() .. "/" .. tab_count
    end
    return ""
end

local sun_status = function()
    if vim.g.is_day then
        return " " .. vim.g.sunset
    else
        return " " .. vim.g.sunrise
    end
end

local copilot_status = function()
    if vim.b.copilot_suggestion_auto_trigger == nil or vim.b.copilot_suggestion_auto_trigger then
        return ""
    end
    return ""
end

local options = {
    options = {
        theme = "auto",
        component_separators = "|",
        section_separators = "",
        disabled_filetypes = {
            "alpha",
        },
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_diagnostic" } } },
        lualine_c = { statusline_tab, { "filename", path = 1 }, "searchcount" },
        lualine_x = {
            sun_status,
            "encoding",
            copilot_status,
            "fileformat",
            "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    -- inactions sections are shown when focus is on another window
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    extensions = {
        "nvim-tree",
    },
}

lualine.setup(options)

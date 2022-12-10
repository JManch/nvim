local ok, blankline = pcall(require, "indent_blankline")

if not ok then
    return
end

local options = {
    filetype_exclude = {
        "help",
        "terminal",
        "alpha",
        "packer",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "Mason",
        "checkhealth",
        "man",
        "",
    },
    show_trailing_blankline_indent = true,
    show_end_of_line = true,
    show_current_context = false,
}

blankline.setup(options)

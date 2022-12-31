return {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = {
        filetype_exclude = {
            "help",
            "terminal",
            "alpha",
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
    },
}

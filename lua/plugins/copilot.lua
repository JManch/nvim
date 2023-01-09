return {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    enabled = false,
    opts = {
        panel = {
            enabled = false,
            keymap = {
                jump_prev = false,
                jump_next = false,
                accept = false,
                refresh = false,
                open = false,
            },
        },
        suggestion = {
            auto_trigger = false,
            keymap = {
                accept = "<C-x>",
                next = false,
                prev = false,
                dismiss = false,
            },
        },
    },
    init = function()
        vim.api.nvim_create_user_command("ToggleCopilot", function()
            require("copilot.suggestion").toggle_auto_trigger()
        end, {})
    end,
}

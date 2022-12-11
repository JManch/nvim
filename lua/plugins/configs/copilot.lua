local ok, copilot = pcall(require, "copilot")

if not ok then
    return
end

local options = {
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
        auto_trigger = true,
        keymap = {
            accept = "<Right>",
            next = false,
            prev = false,
            dismiss = false,
        },
    },
}

vim.api.nvim_create_user_command("ToggleCopilot", function()
    require("copilot.suggestion").toggle_auto_trigger()
end, {})

copilot.setup(options)

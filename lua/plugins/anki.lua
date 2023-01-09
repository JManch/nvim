return {
    "rareitems/anki.nvim",
    ft = "anki",
    opts = {
        text_support = false,
    },
    init = function()
        vim.api.nvim_create_user_command("AnkiCS325", function()
            require("anki").ankiWithDeck("CS325", "Basic")
        end, {})

        vim.api.nvim_create_user_command("AnkiCS324", function()
            require("anki").ankiWithDeck("CS324", "Basic")
        end, {})
    end,
}

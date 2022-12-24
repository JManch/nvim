local ok, anki = pcall(require, "anki")

if not ok then
    return
end

local options = {
    tex_support = false,
    -- models = {
    --     -- note_type = deck
    --     ["Basic"] = "Testing",
    -- }
}

anki.setup(options)

vim.api.nvim_create_user_command("AnkiCS325", function()
    anki.ankiWithDeck("CS325", "Basic")
end, {})

vim.api.nvim_create_user_command("AnkiCS324", function()
    anki.ankiWithDeck("CS324", "Basic")
end, {})

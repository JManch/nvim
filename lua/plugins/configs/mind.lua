local ok, mind = pcall(require, "mind")

if not ok then
    return
end

-- TODO: Finish configuring this
local options = {
    persistence = {
        state_path = "~/.local/share/mind.nvim/mind.json",
        data_dir = "~/.local/share/mind.nvim/data",
    },
    edit = {
        data_extension = ".norg",
        data_header = "* %s",
        copy_link_format = "{%s}[]",
    },
    -- tree = {
    --
    -- }
}

mind.setup(options)

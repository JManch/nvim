return {
    "phaazon/mind.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = {
        -- TODO: Finish config
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
    },
}

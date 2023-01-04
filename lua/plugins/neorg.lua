return {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = "Neorg sync-parsers",
    config = {
        load = {
            ["core.defaults"] = {},
            ["core.norg.completion"] = {
                config = {
                    engine = "nvim-cmp",
                },
            },
            ["core.norg.concealer"] = {},
        },
    },
}

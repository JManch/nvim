return {
    "nvim-neorg/neorg",
    ft = "norg",
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

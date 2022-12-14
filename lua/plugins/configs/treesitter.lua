local ok, treesitter = pcall(require, "nvim-treesitter.configs")

if not ok then
    return
end

local options = {
    auto_install = true,
    ensure_installed = { "lua", "norg" },
    indent = {
        enable = true,
    },
    highlight = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = { query = "@function.outer", desc = "Select outer function" },
                ["if"] = { query = "@function.inner", desc = "Select inner function" },
                ["ac"] = { query = "@class.outer", desc = "Select outer class" },
                ["ic"] = { query = "@class.inner", desc = "Select inner class" },
            },
            include_surrounding_whitespace = false,
        },
        swap = {
            enable = true,
            swap_next = { ["<C-f>"] = { query = "@parameter.inner", desc = "Swap parameter formward" } },
            swap_previous = { ["<C-b>"] = { query = "@parameter.inner", desc = "Swap parameter backwards" } },
        },
    },
}

treesitter.setup(options)

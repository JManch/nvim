local ok, treesitter = pcall(require, "nvim-treesitter.configs")

if not ok then
    return
end

local options = {
    auto_install = true,
    ensure_installed = { "lua", "norg" },
    highlight = {
        enable = true,
    },

    indent = {
        enable = true,
    },
}

treesitter.setup(options)

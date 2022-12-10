local M = {}

local function bootstrap()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

    if fn.empty(fn.glob(install_path)) > 0 then
        packer_bootstrap =
            fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd("packadd packer.nvim")
        require("plugins")
        vim.cmd("PackerSync")
    end
end

local options = {
    git = { clone_timeout = 6000 },
    display = {
        working_sym = "ﲊ",
        error_sym = "✗ ",
        done_sym = " ",
        removed_sym = " ",
        moved_sym = "",
        open_fn = function()
            -- Display packer in a window
            return require("packer.util").float({ border = "rounded" })
        end,
    },
    profile = {
        enable = true,
    },
}

local function load_plugins(plugins)
    pcall(require, "impatient")

    local ok, packer = pcall(require, "packer")
    if not ok then
        return
    end

    packer.init(options)
    packer.startup(function(use)
        for _, plugin in pairs(plugins) do
            use(plugin)
        end
    end)
end

M.bootstrap = bootstrap
M.load_plugins = load_plugins

return M

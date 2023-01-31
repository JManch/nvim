return {
    "andweeb/presence.nvim",
    cmd = "EnablePresence",
    opts = {
        neovim_image_text = "Neovim",
    },
    config = function(_, opts)
        vim.api.nvim_create_user_command("EnablePresence", function() end, {})
        require("presence").setup(opts)
    end
}

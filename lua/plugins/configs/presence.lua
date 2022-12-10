local ok, presence = pcall(require, "presence")

if not ok then
    return
end

local options = {
    neovim_image_text = "Neovim",
    log_level = nil,
}

vim.api.nvim_create_user_command("PresenceEnable", function()
    package.loaded.presence:update()
end, {})
vim.api.nvim_create_user_command("PresenceDisable", function()
    package.loaded.presence:cancel()
end, {})

presence:setup(options)

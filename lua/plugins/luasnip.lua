local M = {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
}

M.config = function()
    -- HACK: Temporary fix for luasnip snapping me back into old snippets
    -- when pressing tab. Waiting for https://github.com/L3MON4D3/LuaSnip/issues/656
    -- this pr to add an option to exit snip when switching to normal
    -- mode
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    local unlinkgrp = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", {})

    vim.api.nvim_create_autocmd("ModeChanged", {
        group = unlinkgrp,
        pattern = { "s:n", "i:*" },
        desc = "Forget the current snippet when leaving the insert mode",
        callback = function(evt)
            if luasnip.session and luasnip.session.current_nodes[evt.buf] and not luasnip.session.jump_active then
                luasnip.unlink_current()
            end
        end,
    })
end

return M

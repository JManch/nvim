local ok, gitsigns = pcall(require, "gitsigns")

if not ok then
    return
end

local map = require("core.mappings").map

local options = {
    signcolumn = true,
    numhl = true,
    attach_to_untracked = false,
    on_attach = function(_)
        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                gitsigns.next_hunk()
            end)
            return "<Ignore>"
        end, "Gitsigns next hunk", { expr = true })

        map("n", "[c", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                gitsigns.prev_hunk()
            end)
            return "<Ignore>"
        end, "Gitsigns previous hunk", { expr = true })

        -- Actions
        map({ "n", "v" }, "<LEADER>hs", ":Gitsigns stage_hunk<CR>", "Gitsigns stage hunk")
        map({ "n", "v" }, "<LEADER>hr", ":Gitsigns reset_hunk<CR>", "Gitsigns reset hunk")
        map("n", "<LEADER>hS", gitsigns.stage_buffer, "Gitsigns stage buffer")
        map("n", "<LEADER>hu", gitsigns.undo_stage_hunk, "Gitsigns undo stage buffer")
        map("n", "<LEADER>hR", gitsigns.reset_buffer, "Gitsigns reset buffer")
        map("n", "<LEADER>hp", gitsigns.preview_hunk, "Gitsigns preview hunk")
        map("n", "<LEADER>hb", function()
            gitsigns.blame_line({ full = true })
        end, "Gitsigns blame line")
        map("n", "<LEADER>ht", gitsigns.toggle_current_line_blame, "Gitsigns toggle current line blame")
        map("n", "<LEADER>hd", gitsigns.diffthis, "Gitsigns view index file diff")
        map("n", "<LEADER>hD", function()
            gitsigns.diffthis("~")
        end, "Gitsigns view file diff against last commit")
        map("n", "<LEADER>td", gitsigns.toggle_deleted, "Gitsigns toggle deleted")
    end,
}

gitsigns.setup(options)

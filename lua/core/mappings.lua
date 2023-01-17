local M = {}

M.map = function(mode, lhs, rhs, desc, opts)
    local options = { desc = desc }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local map = M.map
local utils = require("core.utils")

map("i", "jk", "<ESC>", "Exit insert mode")
map("i", "<C-b>", "<ESC>^i", "Jump to beginning of line")
map("i", "<C-e>", "<END>", "Jump to end of line")
map("i", "<S-Tab>", utils.bracket_jump, "Jump out of things")

map("n", "<C-h>", "<C-w>h", "Go to the left window")
map("n", "<C-l>", "<C-w>l", "Go to the right window")
map("n", "<C-j>", "<C-w>j", "Go to the down window")
map("n", "<C-k>", "<C-w>k", "Go to the up window")

map("n", "<S-j>", "<CMD>bprevious<CR>", "Go to previous buffer")
map("n", "<S-k>", "<CMD>bnext<CR>", "Go to next buffer")

map("n", "vv", "v$", "Visual select to end of line")

map("n", "<S-e>", "ge", "Go to end of previous word")

map({ "n", "v" }, "<S-h>", "^", "Go to start of line")
map({ "n", "v" }, "<S-l>", "$", "Go to end of line")

map("n", "<C-d>", "<C-d>zz", "Scroll down half a page and centre cursor")
map("n", "<C-u>", "<C-u>zz", "Scroll up half a page and centre cursor")
map("n", "<C-o>", "<C-o>zz", "Go to prev marker and centre cursor")
map("n", "<C-i>", "<C-i>zz", "Go to next marker and centre cursor")

map("n", "<LEADER>v", "<CMD>vsplit<CR><C-l>", "Vertical split current buffer")
map("n", "<S-x>", "<CMD>Bwipeout<CR>", "Close current buffer")
map("n", "<S-z>", utils.delete_hidden_buffers, "Close all hidden buffers")
map("n", "ZZ", "<CMD>wa<CR><CMD>qa<CR>", "Write all buffers and quit all")

map("n", "<LEADER>y", '"+y', "Yank to system register")
map("n", "<LEADER>Y", '"+y$', "Yank till end of line to system register")
map("n", "<LEADER>p", '"+p', "Put from system register")
map("n", "<LEADER>P", '"+P', "Put before from system register")

map("n", "<LEADER>o", "o<ESC>", "Create new line below")
map("n", "<LEADER>O", "O<ESC>", "Create new line above")

map("n", "<LEADER>c", "<CMD>nohl<CR>", "Clear search highlighting")

map("n", "<LEADER>l", "<CMD>SunsetToggle<CR>", "Toggle sunset theme")

map("v", "<leader>y", '"+y', "Yank to system register")
map("v", "<leader>p", '"+p', "Put from system register")
map("v", "<leader>P", '"+P', "Put before from system register")

return M

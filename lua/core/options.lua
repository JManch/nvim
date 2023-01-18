local g = vim.g
local api = vim.api

-- General
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.exrc = true -- Load vim config in current dir
vim.opt.ignorecase = true -- Case-insensitive search
vim.opt.smartcase = true -- Smart case-sensitive search
vim.opt.swapfile = true -- Enable swap files
vim.opt.undofile = true -- Store undo history
vim.opt.diffopt:append("linematch:60")
g.mapleader = " " -- Custom leader
g.maplocalleader = "," -- Local leader used for neorg
api.nvim_del_keymap("n", "<C-L>") -- Delete clashing keymap

-- UI
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.number = true -- Show absolute line number
vim.opt.wrap = false -- Disable text wrapping
vim.opt.linebreak = true -- Wrap at words rather than characters
vim.opt.termguicolors = true -- Enable 24-bit RBG colors
vim.opt.scrolloff = 8 -- Scroll before reaching edge
vim.opt.signcolumn = "yes" -- Diagnostic icon column
vim.opt.showmode = false -- Hide mode
vim.opt.splitright = true -- Vertical split to the right
vim.opt.splitbelow = true -- Horizontal split below
vim.opt.showtabline = 0 -- Hide tabline
vim.opt.list = true -- Show tab, space and new line chars
vim.opt.listchars:append("eol:↴") -- Custom new line char
vim.opt.listchars:append("trail:·") -- Custom space char
vim.opt.listchars:append("tab:  ") -- Custom tab char
vim.opt.cmdheight = 1 -- Hide command bar
vim.opt.fillchars = { eob = " " }
g.custom_winbar = "%=%m %t" -- Custom winbar

-- Tabs, indent and folding
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Shift 4 spaces when tab
vim.opt.tabstop = 4 -- 1 tab == 4 spaces
vim.opt.smartindent = true -- Autoindent new lines
vim.opt.foldenable = false -- Disable folding
vim.opt.textwidth = 79 -- 79 is default anyway

-- Performance
vim.opt.hidden = true -- Enable background buffers
vim.opt.updatetime = 250 -- Trigger event wait time (ms)
vim.opt.timeoutlen = 600 -- Time to wait for mapped sequence (ms)

-- Disable providers
g["loaded_python3_provider"] = 0
g["loaded_node_provider"] = 0
g["loaded_perl_provider"] = 0

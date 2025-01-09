local g = vim.g
local o = vim.o
local opt = vim.opt

-- General
o.timeoutlen = 600
o.mouse = 'a'
o.exrc = true
o.ignorecase = true
o.smartcase = true
o.spelllang = 'en_gb'
opt.jumpoptions = { 'stack', 'view' }
opt.diffopt:append('linematch:60')
g.mapleader = ' '
g.maplocalleader = ','
local dict_path = vim.fs.normalize(vim.fn.stdpath('data') .. '/en.dict')
if vim.loop.fs_stat(dict_path) ~= nil then
  opt.dictionary:append(dict_path)
end

-- UI
o.relativenumber = true
o.number = true
o.wrap = false
o.linebreak = true
o.showbreak = '>'
opt.fillchars = { eob = ' ' }
o.scrolloff = 8
o.signcolumn = 'yes'
o.showmode = false
o.splitright = true
o.splitbelow = true
o.showtabline = 0
o.list = true
o.laststatus = 3
opt.completeopt = {
  'menu',
  'menuone',
  'noselect',
  'preview',
  --[[ , 'fuzzy' ]]
}
opt.listchars:append({
  trail = '·',
  tab = '  ',
})

-- Tabs, indent and folding
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.foldenable = false
o.breakindent = true

-- Disable unused providers
g['loaded_node_provider'] = 0
g['loaded_perl_provider'] = 0
g['loaded_ruby_provider'] = 0
g['loaded_gem_provider'] = 0

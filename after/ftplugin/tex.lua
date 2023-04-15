local map = require('core.mappings').map
map('n', 'j', 'gj', 'Soft wrap line jump down', { buffer = true })
map('n', 'k', 'gk', 'Soft wrap line jump up', { buffer = true })
map('v', 'j', 'gj', 'Soft wrap line visual jump down', { buffer = true })
map('v', 'k', 'gk', 'Soft wrap line visual jump up', { buffer = true })
vim.opt_local.colorcolumn = '80'
vim.opt_local.wrap = true
vim.opt_local.textwidth = 0
vim.cmd('SetDictionaryCompletion true')

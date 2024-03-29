local M = {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
}

M.opts = {
  signcolumn = true,
  numhl = false,
  attach_to_untracked = false,
  on_attach = function(_)
    local map = require('core.mappings').map
    local gitsigns = package.loaded.gitsigns

    map('n', ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function() gitsigns.next_hunk() end)
      return '<Ignore>'
    end, 'Gitsigns next hunk', { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function() gitsigns.prev_hunk() end)
      return '<Ignore>'
    end, 'Gitsigns previous hunk', { expr = true })

    map('n', '<LEADER>hp', gitsigns.preview_hunk, 'Gitsigns preview hunk')
    map('n', '<LEADER>hb', function() gitsigns.blame_line({ full = true }) end, 'Gitsigns blame line')
    map('n', '<LEADER>ht', gitsigns.toggle_current_line_blame, 'Gitsigns toggle current line virtual text blame')
    map('n', '<LEADER>hd', gitsigns.diffthis, 'Gitsigns view index file diff')
    map('n', '<LEADER>hD', function() gitsigns.diffthis('~') end, 'Gitsigns view file diff against last commit')
    map('n', '<LEADER>td', gitsigns.toggle_deleted, 'Gitsigns toggle deleted')
  end,
  preview_config = {
    border = 'rounded',
  },
}

return M

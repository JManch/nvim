return {
  'JManch/workspaces.nvim',
  cmd = { 'WorkspacesOpen', 'WorkspacesAdd', 'WorkspacesList' },
  keys = {
    { '<LEADER>w', '<CMD>WorkspacesOpen<CR>', desc = 'Workspaces open global' },
    { '<LEADER>Ww', '<CMD>WorkspacesOpen local<CR>', desc = 'Workspaces open window' },
    { '<LEADER>Wt', '<CMD>WorkspacesOpen tab<CR>', desc = 'Workspaces open tab' },
  },
  opts = {
    hooks = {
      open = function()
        vim.notify('Loaded workspace ' .. require('workspaces').name(), vim.log.levels.INFO, {
          { title = 'Workspaces', timeout = '1000' },
        })
      end,
    },
  },
}

return {
  'natecraddock/workspaces.nvim',
  -- Commit before the plugin got unnecessarily bloated
  commit = 'f55ad0a3688840ace255d327a5e5bb16b9ff5a17',
  event = 'VeryLazy',
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

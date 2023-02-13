return {
  'natecraddock/workspaces.nvim',
  dependencies = {
    'natecraddock/sessions.nvim',
    opts = {
      session_filepath = vim.fn.resolve(vim.fn.stdpath('data') .. '/sessions'),
      absolute = true,
    },
  },
  event = 'VeryLazy',
  opts = {
    hooks = {
      open = function()
        vim.notify('Loaded workspace ' .. require('workspaces').name(), vim.log.levels.INFO, {
          { title = 'Workspaces', timeout = '1000' },
        })
        require('sessions').load(nil, { silent = true })
      end,
    },
  },
}

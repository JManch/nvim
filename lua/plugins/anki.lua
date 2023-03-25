local M = {
  'rareitems/anki.nvim',
  ft = 'anki',
  cmd = { 'AnkiSetDeck', 'AnkiSetTags', 'AnkiCreateCard' },
}

M.deck = ''
M.card = 'Basic'
M.tags = ''

M.config = function()
  local anki = require('anki')
  anki.setup()

  vim.api.nvim_create_user_command('AnkiSetDeck', function(cmd)
    M.deck = cmd.args
    vim.notify('Set deck to ' .. M.deck, vim.log.levels.INFO)
  end, { nargs = 1 })

  vim.api.nvim_create_user_command('AnkiSetTags', function(cmd)
    M.tags = cmd.args
    vim.notify('Set tags to ' .. M.tags, vim.log.levels.INFO)
  end, { nargs = 1 })

  vim.api.nvim_create_user_command('AnkiCreateCard', function()
    if M.deck == '' then
      vim.notify('Deck has not been set', vim.log.levels.WARN)
      return
    elseif M.tags == '' then
      vim.notify('Tags have not been set', vim.log.levels.WARN)
    end
    vim.cmd.edit('~/card.anki')
    anki.ankiWithDeck(M.deck, M.card, { tags = M.tags })
  end, {})

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('AnkiFileType', {}),
    pattern = 'anki',
    callback = function()
      print('Called anki ft callback')
      local map = require('core.mappings').map
      map(
        'n',
        '<C-a>',
        '<CMD>AnkiSend<CR><CMD>AnkiCreateCard<CR>',
        'Send anki flashcard and create new',
        { buffer = true }
      )
      map(
        'n',
        '<C-s>',
        '<CMD>AnkiSendGui<CR><CMD>AnkiCreateCard<CR>',
        'Send anki flashcard to GUI and create new',
        { buffer = true }
      )
      map('n', 'j', 'gj', 'Soft wrap line jump down', { buffer = true })
      map('n', 'k', 'gk', 'Soft wrap line jump up', { buffer = true })
      map('v', 'j', 'gj', 'Soft wrap line visual jump down', { buffer = true })
      map('v', 'k', 'gk', 'Soft wrap line visual jump up', { buffer = true })
      vim.opt_local.conceallevel = 2
      vim.opt_local.concealcursor = 'nvi'
      vim.opt_local.wrap = true
      vim.opt_local.textwidth = 0
    end,
  })
end

return M

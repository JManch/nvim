return {
  'shortcuts/no-neck-pain.nvim',
  cmd = 'NoNeckPain',
  keys = {
    { '<LEADER>z', '<CMD>NoNeckPain<CR>', desc = 'Toggle centered buffer' },
  },
  opts = {
    toggleMapping = false,
    widthUpMapping = false,
    widthDownMapping = false,
  },
}

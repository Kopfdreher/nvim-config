return {
  'pablopunk/pi.nvim',
  cmd = { 'PiAsk', 'PiAskSelection', 'PiCancel', 'PiToggleSession', 'PiToggleAgentsMd', 'PiLog' },
  keys = {
    { '<leader>ai', '<cmd>PiAsk<cr>', mode = 'n', desc = 'Ask pi' },
    { '<leader>ai', '<cmd>PiAskSelection<cr>', mode = 'v', desc = 'Ask pi (selection)' },
  },
  config = function()
    require('pi').setup {}
  end,
}

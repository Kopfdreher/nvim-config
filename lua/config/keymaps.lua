-- Native window navigation (no tmux-navigator plugin; Rex/multiplexer
-- owns pane splits at the terminal layer, Neovim owns window movement).
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

vim.keymap.set('n', '<leader>d', function()
  vim.diagnostic.open_float { border = 'rounded' }
end, { desc = 'Show diagnostics for this line' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = false }
end, { desc = 'Next diagnostic' })

vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = false }
end, { desc = 'Previous diagnostic' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Let Rex's background / opacity / styling show through: strip Neovim bg paints.
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  group = vim.api.nvim_create_augroup('rex-transparent-bg', { clear = true }),
  callback = function()
    local highlights = {
      'Normal',
      'NormalNC',
      'SignColumn',
      'EndOfBuffer',
      'NormalFloat',
      'FloatBorder',
      'TelescopeNormal',
      'TelescopeBorder',
      'NeoTreeNormal',
      'NeoTreeNormalNC',
    }
    for _, hl in ipairs(highlights) do
      vim.api.nvim_set_hl(0, hl, { bg = 'none' })
    end
  end,
})

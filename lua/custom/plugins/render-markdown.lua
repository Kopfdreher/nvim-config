-- In lua/custom/plugins/render-markdown.lua
return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
  ft = 'markdown', -- Only load for markdown files
  config = function()
    require('render-markdown').setup()
  end,
}

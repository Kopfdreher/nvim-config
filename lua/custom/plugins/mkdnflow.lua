-- In lua/custom/plugins/mkdnflow.lua
return {
  'jakewvincent/mkdnflow.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  -- You can customize the setup with your own options
  config = function()
    require('mkdnflow').setup {}
  end,
}

-- In lua/custom/plugins/zk.lua
return {
  'zk-org/zk-nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    require('zk').setup {
      -- This tells zk-nvim to use Telescope for finding notes, etc.
      picker = 'telescope',

      -- This is the path to the notebook you initialized in Step 2.
      -- If you open Neovim from inside your notebook directory, you don't need this.
      -- But it's good practice to set it explicitly.
      --
      -- If you have one notebook:
      -- cwd = "~/MyNotes"
      --
      -- If you have multiple notebooks, you can list them and zk-nvim will
      -- automatically detect which one you are in.
      -- cwd_fallbacks = { "~/MyNotes", "~/WorkNotes" },
    }
  end,
}

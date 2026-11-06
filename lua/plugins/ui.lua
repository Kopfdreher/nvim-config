return {
  { 'NMAC427/guess-indent.nvim', opts = {} },
  'ThePrimeagen/vim-be-good',

  { -- Keybind helper
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {},
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        transparent = true, -- let Rex bg / opacity show through
        styles = {
          comments = { italic = false },
          sidebars = 'transparent',
          floats = 'transparent',
        },
      }
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      require('mini.statusline').setup { use_icons = vim.g.have_nerd_font }
    end,
  },
}

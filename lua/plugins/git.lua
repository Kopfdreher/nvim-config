-- Git: gitsigns + diffview
return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, 'Next hunk')
        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, 'Previous hunk')

        map('n', '<leader>hs', gitsigns.stage_hunk, 'Stage hunk')
        map('n', '<leader>hr', gitsigns.reset_hunk, 'Reset hunk')
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'Stage hunk')
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, 'Reset hunk')
        map('n', '<leader>hp', gitsigns.preview_hunk, 'Preview hunk')
        map('n', '<leader>hb', function()
          gitsigns.blame_line { full = true }
        end, 'Blame line')
        map('n', '<leader>hd', gitsigns.diffthis, 'Diff against index')
      end,
    },
  },

  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open diff view' },
      { '<leader>gf', '<cmd>DiffviewFileHistory %<cr>', desc = 'Current file history' },
      { '<leader>gF', '<cmd>DiffviewFileHistory<cr>', desc = 'Branch history' },
      { '<leader>gq', '<cmd>DiffviewClose<cr>', desc = 'Close diff view' },
    },
  },
}

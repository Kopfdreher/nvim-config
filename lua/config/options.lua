-- Disable unused providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = os.getenv 'USE_NERD' == '1'

-- Options
vim.opt.backupcopy = 'yes'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- 2-space indentation default
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Transitional shim: Mason is gone, but its binaries still live here until
-- you reinstall them via brew/npm (e.g. `brew install stylua prettierd`).
-- Keeps conform + LSP working meanwhile. Delete once $PATH provides them.
local mason_bin = vim.fn.stdpath 'data' .. '/mason/bin'
if vim.uv.fs_stat(mason_bin) and not string.find(vim.env.PATH, mason_bin, 1, true) then
  vim.env.PATH = mason_bin .. ':' .. vim.env.PATH
end

vim.filetype.add {
  extension = { tpp = 'cpp', hpp = 'cpp' },
}

-- Quiet, low-distraction diagnostics (view on demand with <C-w>d or gl)
vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}

-- LSP attaches to binaries on $PATH (no Mason — install via brew/system).
-- e.g. `brew install llvm lua-language-server typescript-language-server stylua`
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} },
      { 'folke/lazydev.nvim', ft = 'lua', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      -- grn, gra, grr, gri, grt, gO, K and ]d / [d / <C-w>d are Neovim defaults.
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local servers = {
        clangd = {
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--config-yaml=Diagnostics: { UnusedIncludes: None }',
            '--clang-tidy-checks=-misc-include-cleaner',
          },
          root_markers = {
            '.clangd',
            '.clang-tidy',
            '.clang-format',
            'compile_commands.json',
            'compile_flags.txt',
            'Makefile',
            'configure.ac',
            '.git',
          },
        },
        lua_ls = { settings = { Lua = { completion = { callSnippet = 'Replace' } } } },
        ts_ls = {},
        eslint = {},
      }

      for name, server in pairs(servers) do
        vim.lsp.config(name, vim.tbl_deep_extend('force', { capabilities = capabilities }, server))
      end
      -- Only enable servers whose binary exists on $PATH.
      local bins = { clangd = 'clangd', lua_ls = 'lua-language-server', ts_ls = 'typescript-language-server', eslint = 'vscode-eslint-language-server' }
      local to_enable = {}
      for name, bin in pairs(bins) do
        if vim.fn.executable(bin) == 1 then
          table.insert(to_enable, name)
        else
          vim.schedule(function()
            vim.notify(('lsp: %s not on $PATH (skipped)'):format(name), vim.log.levels.WARN)
          end)
        end
      end
      vim.lsp.enable(to_enable)
    end,
  },
}

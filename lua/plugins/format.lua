-- Deliberate, manual formatting only (<leader>f). No format-on-save surprises.
local defaults = require 'custom.format_defaults'

local function js_formatters(bufnr)
  if defaults.has_project_style(bufnr) then
    return { 'prettierd', 'prettier', stop_after_first = true }
  end
  -- prettierd treats extra flags as file paths, so the default style goes
  -- through the prettier CLI only.
  return { 'prettier_default' }
end

return {
  {
    'stevearc/conform.nvim',
    cmd = { 'ConformInfo' },
    keys = {
      { '<leader>f', function() require('conform').format { async = true, lsp_format = 'fallback' } end, mode = { 'n', 'v' }, desc = '[F]ormat buffer' },
    },
    opts = {
      notify_on_error = true,
      notify_no_formatters = true,
      format_on_save = false,
      formatters = {
        prettier_default = {
          command = 'prettier',
          args = {
            '--stdin-filepath',
            '$FILENAME',
            '--single-quote',
            '--no-semi',
            '--tab-width',
            '2',
          },
          stdin = true,
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        cpp = { 'clang-format' },
        javascript = js_formatters,
        typescript = js_formatters,
        javascriptreact = js_formatters,
        typescriptreact = js_formatters,
        json = { 'prettierd', 'prettier', stop_after_first = true },
        yaml = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },
}

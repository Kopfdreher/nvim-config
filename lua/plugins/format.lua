-- Manual formatting only (<leader>f).
-- JS/TS: project ESLint, else project Oxlint, else single-quote Prettier.

local eslint_script = [=[
const { spawnSync } = require('child_process')
let input = ''
process.stdin.on('data', chunk => { input += chunk })
process.stdin.on('end', () => {
  const bin = process.argv[1]
  const file = process.argv[2]
  const res = spawnSync(bin, [
    '--fix-dry-run', '--format', 'json', '--stdin', '--stdin-filename', file,
  ], { input, encoding: 'utf8' })
  try {
    const report = JSON.parse(res.stdout)
    const fixed = report[0] && report[0].output
    process.stdout.write(typeof fixed === 'string' ? fixed : input)
  } catch (err) {
    process.stderr.write(res.stderr || res.stdout || String(err))
    process.exit(1)
  }
})
]=]

local function find_bin(ctx, name)
  return vim.fs.find('node_modules/.bin/' .. name, { upward = true, path = ctx.dirname })[1]
end

local function has_eslint(ctx)
  if not find_bin(ctx, 'eslint') then
    return false
  end
  return vim.fs.find({
    'eslint.config.js',
    'eslint.config.mjs',
    'eslint.config.cjs',
    'eslint.config.ts',
    '.eslintrc',
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.json',
  }, { upward = true, path = ctx.dirname })[1] ~= nil
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
        eslint_fix = {
          command = 'node',
          stdin = true,
          condition = function(_, ctx)
            return has_eslint(ctx)
          end,
          args = function(_, ctx)
            return { '-e', eslint_script, find_bin(ctx, 'eslint'), ctx.filename ~= '' and ctx.filename or 'stdin.js' }
          end,
        },
        oxlint = {
          condition = function(_, ctx)
            return find_bin(ctx, 'oxlint') ~= nil
          end,
        },
        prettier_default = {
          command = 'prettier',
          stdin = true,
          args = { '--stdin-filepath', '$FILENAME', '--single-quote', '--no-semi', '--tab-width', '2' },
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        cpp = { 'clang-format' },
        javascript = { 'eslint_fix', 'oxlint', 'prettier_default', stop_after_first = true },
        typescript = { 'eslint_fix', 'oxlint', 'prettier_default', stop_after_first = true },
        javascriptreact = { 'eslint_fix', 'oxlint', 'prettier_default', stop_after_first = true },
        typescriptreact = { 'eslint_fix', 'oxlint', 'prettier_default', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        yaml = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },
}

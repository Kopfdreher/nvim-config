local M = {}

local eslint_files = {
  'eslint.config.js',
  'eslint.config.mjs',
  'eslint.config.cjs',
  'eslint.config.ts',
  'eslint.config.mts',
  'eslint.config.cts',
  '.eslintrc',
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.mjs',
  '.eslintrc.json',
  '.eslintrc.yml',
  '.eslintrc.yaml',
}

local prettier_files = {
  '.prettierrc',
  '.prettierrc.json',
  '.prettierrc.json5',
  '.prettierrc.yml',
  '.prettierrc.yaml',
  '.prettierrc.toml',
  '.prettierrc.js',
  '.prettierrc.cjs',
  '.prettierrc.mjs',
  '.prettierrc.ts',
  'prettier.config.js',
  'prettier.config.cjs',
  'prettier.config.mjs',
  'prettier.config.ts',
}

local function start_dir(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr or 0)
  if name ~= '' then
    return vim.fn.fnamemodify(name, ':h')
  end
  return vim.fn.getcwd()
end

local function package_has_key(bufnr, key)
  local pkg = vim.fs.find('package.json', { path = start_dir(bufnr), upward = true })[1]
  if not pkg then
    return false
  end
  local ok, lines = pcall(vim.fn.readfile, pkg)
  if not ok then
    return false
  end
  return vim.fn.match(lines, [[^\s*"]] .. key .. [["%s*:]]) >= 0
end

function M.has_project_style(bufnr)
  local start = start_dir(bufnr)
  if vim.fs.find(eslint_files, { path = start, upward = true })[1] then
    return true
  end
  if vim.fs.find(prettier_files, { path = start, upward = true })[1] then
    return true
  end
  if package_has_key(bufnr, 'eslintConfig') or package_has_key(bufnr, 'prettier') then
    return true
  end
  return false
end

function M.project_eslint(bufnr)
  return vim.fs.find('node_modules/.bin/eslint', { path = start_dir(bufnr), upward = true })[1]
end

return M

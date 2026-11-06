return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      -- JS/TS uses the eslint linter (reads flat eslint.config.* / legacy
      -- .eslintrc automatically). oxlint is used too when its binary exists.
      -- Install via brew: `brew install eslint_d oxlint prettierd` (or npm i -g).
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        javascript = { 'eslint' },
        typescript = { 'eslint' },
        javascriptreact = { 'eslint' },
        typescriptreact = { 'eslint' },
        vue = { 'eslint' },
      }
      if vim.fn.executable 'oxlint' == 1 then
        for _, ft in ipairs { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' } do
          table.insert(lint.linters_by_ft[ft], 1, 'oxlint')
        end
      end

      -- Only the project's own eslint. No global or fallback binary, so a
      -- buffer without node_modules/.bin/eslint does not error on BufEnter.
      local function project_eslint()
        return require('custom.format_defaults').project_eslint(0)
      end

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if not vim.bo.modifiable then
            return
          end
          local names = lint.linters_by_ft[vim.bo.filetype]
          if not names then
            return
          end
          local run = {}
          local bin = project_eslint()
          for _, name in ipairs(names) do
            if name == 'eslint' then
              if bin then
                lint.linters.eslint.cmd = bin
                table.insert(run, name)
              end
            else
              table.insert(run, name)
            end
          end
          if #run > 0 then
            lint.try_lint(run)
          end
        end,
      })
    end,
  },
}

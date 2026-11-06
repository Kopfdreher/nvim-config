return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local parsers = {
        'javascript',
        'typescript',
        'tsx',
        'go',
        'html',
        'c',
        'cpp',
        'lua',
        'vim',
        'vimdoc',
        'query',
        'markdown',
        'markdown_inline',
      }

      local function start(buf, lang)
        if vim.api.nvim_buf_is_valid(buf) and vim.treesitter.language.add(lang) then
          vim.treesitter.start(buf, lang)
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      require('nvim-treesitter').install(parsers)

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end

          local installed = require('nvim-treesitter').get_installed 'parsers'
          if vim.tbl_contains(installed, lang) or vim.treesitter.language.add(lang) then
            start(args.buf, lang)
          elseif vim.tbl_contains(parsers, lang) then
            require('nvim-treesitter').install(lang):await(function()
              start(args.buf, lang)
            end)
          end
        end,
      })
    end,
  },
}

return {
  'pablopunk/pi.nvim',
  cmd = { 'PiAsk', 'PiAskSelection', 'PiCancel', 'PiToggleSession', 'PiLog' },
  keys = {
    { '<leader>ai', '<cmd>PiAsk<cr>', mode = 'n', desc = 'Ask pi' },
    { '<leader>ai', '<cmd>PiAskSelection<cr>', mode = 'v', desc = 'Ask pi (selection)' },
  },
  config = function()
    -- Look for AGENTS.md in the current working directory or up the directory tree
    local agents_file = vim.fn.findfile('AGENTS.md', '.;')
    local agents_content = nil

    if agents_file ~= '' and vim.fn.filereadable(agents_file) == 1 then
      agents_content = table.concat(vim.fn.readfile(agents_file), '\n')
    end

    require('pi').setup {
      -- Overrides default system_prompt with AGENTS.md content when available
      system_prompt = agents_content or 'You are a helpful assistant.',

      -- Keep append_system_prompt intact or adjust as desired
      append_system_prompt = 'Always respond concisely.',
    }
  end,
}

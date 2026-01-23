return {
  'vinicius507/ft_nvim',

  ft = { 'c' },

  dependencies = {
    'mfussenegger/nvim-lint',
  },
  config = function()
    -- This is the setup function you provided
    require('ft_nvim').setup {
      -- Configures the 42 Header integration
      header = {
        -- Enable the 42 Header integration (default: true).
        enable = true,
        -- Your Intranet username (default: "marvin").
        username = 'sgavrilo',
        -- Your Intranet email (default: "marvin@42.fr").
        email = 'sgavrilo@student.42berlin.de',
      },
      -- Configures the norminette integration.
      norminette = {
        -- Enable the norminette integration (default: true).
        enable = true,
        -- The command to run norminette (default: "norminette").
        cmd = 'norminette',
        -- A function to conditionally enable the norminette integration (default: nil)
        condition = function()
          return true
        end,
      },
    }
  end,
}

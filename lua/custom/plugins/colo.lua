return {
  {
    'lunacookies/vim-colors-xcode',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd.colo 'xcodedarkhc'
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = true,
    priority = 1000,
    config = function()
      vim.cmd.colo 'carbonfox'
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
  {
    'scottmckendry/cyberdream.nvim',
    lazy = true,
    priority = 1000,
    config = function()
      vim.cmd.colo 'cyberdream'
    end,
  },
  {
    'savq/melange-nvim',
    lazy = true,
    priority = 1000,
    config = function()
      vim.cmd.colo 'melange'
    end,
  },
  {
    lazy = true,
    priority = 1000,
    'tjdevries/colorbuddy.nvim',
    config = function()
      vim.cmd.colo 'gruvbuddy'
    end,
  },
}

return {
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    priority = 1000,
    config = function()
      vim.cmd.colo 'kanagawa'
      vim.cmd [[highlight clear NoiceCmdlineTitle]]
      vim.cmd [[highlight link NoiceCmdlinePopupBorder Normal]]
      vim.cmd [[highlight link NoiceCmdlinePopupTitle Normal]]
      vim.cmd [[highlight NoiceCmdlinePopupTitle cterm=bold gui=bold]]

      -- TODO diagnostics
      -- TODO Noice search bar
      local groups = { 'LineNr', 'SignColumn', 'GitSignsAdd', 'GitSignsChange', 'GitSignsDelete', 'FloatBorder', 'NormalFloat' }
      for _, g in ipairs(groups) do
        vim.cmd('highlight ' .. g .. ' guibg=guibg=#1f1f28')
      end
    end,
  },
  { 'rose-pine/neovim', name = 'rose-pine', lazy = true, priority = 1000 },
  {
    'EdenEast/nightfox.nvim',
    lazy = true,
    priority = 1000,
    config = function()
      vim.cmd.colo 'carbonfox'
    end,
  },
  {
    'craftzdog/solarized-osaka.nvim',
    lazy = true,
    priority = 1000,
    name = 'osaka',
    config = function()
      vim.cmd.colo 'solarized-osaka'
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
    priority = 1000,
    opts = {},
    config = function()
      require('tokyonight').setup {
        styles = {
          comments = { italic = true },
          keywords = {},
          functions = {},
          variables = {},
        },
        ---@param colors ColorScheme
        on_colors = function(colors)
          ---@diagnostic disable-next-line: inject-field
          colors.bg = '#000000'
          colors.bg_dark = '#000000'
          colors.bg_float = '#000000'
          colors.black = '#000000'
        end,
        ---@param hl Highlights
        ---@param c ColorScheme
        on_highlights = function(hl, c)
          hl.TelescopeNormal = {
            bg = c.bg_dark,
          }
          hl.TelescopeBorder = {
            bg = c.bg_dark,
          }
          hl.MatchParen = {
            bold = true,
            underline = true,
          }
          hl.NormalFloat = {
            bg = c.bg_dark,
          }
          hl.FloatBorder = {
            bg = c.bg_dark,
          }
          hl.NormalSB = {
            bg = c.bg_dark,
          }
        end,
      }
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
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colo 'melange'
    end,
  },
  -- TODO: underline word under cursor
  -- TODO: gitsigns highlight groups
  {
    lazy = true,
    priority = 1000,
    'tjdevries/colorbuddy.nvim',
    config = function()
      vim.cmd.colo 'gruvbuddy'
    end,
  },
}

-- vim.cmd.colo zaibatsu
-- vim.cmd [[ highlight NormalFloat guibg=black ]]
-- vim.cmd.colo 'retrobox'
-- return {}

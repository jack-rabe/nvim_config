return {
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
}

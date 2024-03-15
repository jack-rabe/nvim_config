return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
    },
    config = function()
        require("tokyonight").setup({
            ---@param colors ColorScheme
            on_colors = function(colors)
                colors.bg = '#000000'
                colors.bg_dark = '#000000'
                colors.black = '#000000'
            end,
            ---@param highlights Highlights
            ---@param colors ColorScheme
            on_highlights = function(hl, c)
                hl.TelescopeNormal = {
                    bg = c.bg_dark,
                }
                hl.TelescopeBorder = {
                    bg = c.bg_dark,
                }
            end,

        })
        vim.cmd.colorscheme 'tokyonight'
    end,
}

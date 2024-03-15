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
        })
        vim.cmd.colorscheme 'tokyonight-night'
    end,
}

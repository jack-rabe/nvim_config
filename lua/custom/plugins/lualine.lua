return {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
        options = {
            component_separators = '|',
            section_separators = '',
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch' },
            lualine_c = { 'filename', 'diagnostics' },
            lualine_x = { 'filetype' },
            lualine_y = { 'diff' },
            lualine_z = { 'location' }
        },
    },
}

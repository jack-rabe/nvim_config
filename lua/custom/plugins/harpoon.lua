return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
        local harpoon = require("harpoon")

        vim.keymap.set("n", "'m", function() harpoon:list():append() end, { desc = "Harpoon list append file" })
        vim.keymap.set("n", "''", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = 'Harpoon toggle quick menu' })

        vim.keymap.set("n", "'a", function() harpoon:list():select(1) end, { desc = 'Navigate to harpoon file 1' })
        vim.keymap.set("n", "'s", function() harpoon:list():select(2) end, { desc = 'Navigate to harpoon file 2' })
        vim.keymap.set("n", "'d", function() harpoon:list():select(3) end, { desc = 'Navigate to harpoon file 3' })
        vim.keymap.set("n", "'f", function() harpoon:list():select(4) end, { desc = 'Navigate to harpoon file 4' })
        vim.keymap.set("n", "'p", function() harpoon:list():prev() end, { desc = 'Harpoon previous file' })
        vim.keymap.set("n", "'n", function() harpoon:list():next() end, { desc = 'Harpoon next file' })
    end,
}

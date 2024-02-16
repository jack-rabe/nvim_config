-- Configure Harpoon keybinds
local harpoon_ui = require('harpoon.ui')
vim.keymap.set('n', "''", harpoon_ui.toggle_quick_menu, { desc = 'Open harpoon quick menu' })
vim.keymap.set('n', "'a", function()
    harpoon_ui.nav_file(1)
end
, { desc = 'Navigate to harpoon file 1' })
vim.keymap.set('n', "'s", function()
    harpoon_ui.nav_file(2)
end
, { desc = 'Navigate to harpoon file 2' })
vim.keymap.set('n', "'d", function()
    harpoon_ui.nav_file(3)
end
, { desc = 'Navigate to harpoon file 3' })
vim.keymap.set('n', "'f", function()
    harpoon_ui.nav_file(4)
end
, { desc = 'Navigate to next harpoon file' })
vim.keymap.set('n', "'n", harpoon_ui.nav_next, { desc = 'Navigate to next harpoon file' })
vim.keymap.set('n', "'p", harpoon_ui.nav_prev, { desc = 'Navigate to previous harpoon file' })
vim.keymap.set('n', "'m", require('harpoon.mark').add_file, { desc = 'Harpoon add file' })

-- Oil keymaps
vim.keymap.set("n", "<leader>oo", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>of", "<CMD>Oil --float .<CR>", { desc = "Open parent directory" })

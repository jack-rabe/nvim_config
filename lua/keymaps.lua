vim.keymap.set('n', 'ga', '<C-^>', { desc = 'Go to alternate file' })
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<leader>y', ':let @+ = expand("%")<cr>)', { desc = '[Y]ank filename' })
vim.keymap.set('n', '<leader>w', function() vim.api.nvim_command("update") end, { desc = '[W]rite file' })
vim.keymap.set('n', '<leader>q', function() vim.api.nvim_command("quit") end, { desc = '[Q]uit' })

-- Oil keymaps
vim.keymap.set("n", "<leader>oo", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>of", "<CMD>Oil --float .<CR>", { desc = "Open parent directory" })

-- [[ Basic Keymaps ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- Noice keymaps
vim.keymap.set("n", "<leader>nh", function()
  require("noice").cmd("history")
end, { desc = "[N]oice [H]istory" })
vim.keymap.set("n", "<leader>nl", function()
  require("noice").cmd("last")
end, { desc = "[N]oice [L]ast" })

-- Harpoon keymaps
local harpoon = require("harpoon")
harpoon:setup({ settings = { save_on_toggle = true } })

vim.keymap.set("n", "'m", function() harpoon:list():append() end, { desc = "Harpoon list append file" })
vim.keymap.set("n", "''", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
  { desc = 'Harpoon toggle quick menu' })

vim.keymap.set("n", "'a", function() harpoon:list():select(1) end, { desc = 'Navigate to harpoon file 1' })
vim.keymap.set("n", "'s", function() harpoon:list():select(2) end, { desc = 'Navigate to harpoon file 2' })
vim.keymap.set("n", "'d", function() harpoon:list():select(3) end, { desc = 'Navigate to harpoon file 3' })
vim.keymap.set("n", "'f", function() harpoon:list():select(4) end, { desc = 'Navigate to harpoon file 4' })
vim.keymap.set("n", "'p", function() harpoon:list():prev() end, { desc = 'Harpoon previous file' })
vim.keymap.set("n", "'n", function() harpoon:list():next() end, { desc = 'Harpoon next file' })

-- TODO plugin keymaps
local todo = require("todo-comments")
vim.keymap.set("n", "]t", function()
  todo.jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
  todo.jump_prev()
end, { desc = "Previous todo comment" })
vim.keymap.set("n", "<leader>sT", "<CMD>TodoTelescope<CR>", { desc = "[S]earch [T]odos" })
vim.keymap.set("n", "<leader>tq", "<CMD>TodoQuickFix<CR>", { desc = "Send [T]ODO's to [Q]uickfix List" })

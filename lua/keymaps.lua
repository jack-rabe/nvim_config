local wk = require 'which-key'
wk.add {
  { '<leader>p', group = '[p]ersistence' },
  { '<leader>g', group = 'git/diffview' },
  { '<leader>o', group = '[o]verseer' },
  { '<leader>s', group = '[s]earch' },
}

vim.keymap.set('n', '<Esc>', function()
  pcall(require('noice').cmd, 'dismiss')
  vim.cmd [[ nohlsearch ]]
end)
vim.keymap.set({ 'n', 'v' }, 'x', '"_x')
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete to _ register' })
vim.keymap.set('n', 'ga', '<C-^>', { desc = 'Go to alternate file' })
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<leader>y', ':let @+ = expand("%")<cr>)', { desc = '[Y]ank filename' })
vim.keymap.set('n', '<leader>w', function()
  vim.api.nvim_command 'update'
end, { desc = '[W]rite file' })
vim.keymap.set('n', '<leader>q', function()
  vim.api.nvim_command 'quit'
end, { desc = '[Q]uit' })
vim.keymap.set('n', '<C-q>', function()
  vim.api.nvim_command 'quit'
end, { desc = '[Q]uit' })

-- Oil keymaps
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
-- vim.keymap.set('n', '<leader>of', '<CMD>Oil --float .<CR>', { desc = 'Open parent directory' })

-- Basic Keymaps
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- Noice keymaps
vim.keymap.set('n', '<leader>nl', function()
  require('noice').cmd 'last'
end, { desc = '[N]oice [L]ast' })
vim.keymap.set({ 'n', 'i', 's' }, '<c-d>', function()
  if not require('noice.lsp').scroll(4) then
    return '<c-d>'
  end
end, { silent = true, expr = true })

vim.keymap.set({ 'n', 'i', 's' }, '<c-u>', function()
  if not require('noice.lsp').scroll(-4) then
    return '<c-u>'
  end
end, { silent = true, expr = true })

-- Neogit keymaps
local neogit = require 'neogit'
vim.keymap.set('n', '<leader>gg', function()
  neogit.open()
end, { desc = 'Open Neogit' })

-- Diffview keymaps
local diffview = require 'diffview'
vim.keymap.set('n', '<leader>gd', function()
  diffview.open {}
end, { desc = 'Open Diffview' })
vim.keymap.set('n', '<leader>gf', function()
  vim.cmd [[ DiffviewFileHistory % ]]
end, { desc = 'Diffview File History' })
vim.keymap.set('n', '<leader>gc', function()
  diffview.close()
end, { desc = 'Close Diffview' })

-- Overseer keymaps
local overseer = require 'overseer'
vim.keymap.set('n', '<leader>or', function()
  overseer.open()
end, { desc = '[O]verseer [O]pen' })
vim.keymap.set('n', '<leader>or', function()
  vim.cmd [[OverseerRun]]
end, { desc = 'Overseer Run' })

-- persistence keymaps
-- load the session for the current directory
vim.keymap.set('n', '<leader>ps', function()
  require('persistence').load()
end, { desc = 'Persistence Load' })

-- select a session to load
vim.keymap.set('n', '<leader>pS', function()
  require('persistence').select()
end, { desc = 'Persistence Select' })

-- load the last session
vim.keymap.set('n', '<leader>pl', function()
  require('persistence').load { last = true }
end, { desc = 'Persistence Load Last' })

-- stop Persistence => session won't be saved on exit
vim.keymap.set('n', '<leader>pd', function()
  require('persistence').stop()
end, { desc = 'Persistence Stop' })

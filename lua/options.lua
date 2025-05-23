-- [[ setting options]]
vim.o.hlsearch = true
vim.wo.number = true
vim.opt.scrolloff = 5
vim.wo.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- Enable mouse mode
vim.o.mouse = 'a'
-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true -- Save undo history
-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
-- Decrease update time
vim.o.updatetime = 750
vim.o.timeoutlen = 600
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
-- limit number of options shown in popup menus like cmp
vim.opt.pumheight = 12

-- sets how neovim will display certain whitespace in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', nbsp = '␣', eol = '↵' }
vim.diagnostic.config {
  virtual_lines = true,
  -- virtual_text = {
  --   prefix = '»',
  -- },
}

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99

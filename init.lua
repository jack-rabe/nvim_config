vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    opts = {},
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    ---@class wk.Opts
    opts = {
      preset = 'helix',
      delay = 300,
    },
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim', -- optional - Diff integration
      'nvim-telescope/telescope.nvim',
    },
    config = true,
  },
  -- TODO try mini-surround?
  'tpope/vim-surround',
  'tpope/vim-sleuth',
  'tpope/vim-repeat',
  -- NOTE: This is where your plugins related to LSP can be installed.
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Additional lua configuration, makes nvim stuff amazing!
      -- consider https://github.com/folke/lazydev.nvim?
    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  -- {
  --   'nvim-neotest/neotest',
  --   dependencies = {
  --     'nvim-neotest/nvim-nio',
  --     'nvim-lua/plenary.nvim',
  --     'antoinemadec/FixCursorHold.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --     { 'fredrikaverpil/neotest-golang', version = '*' }, -- tracks official releases
  --   },
  --   config = function()
  --     ---@diagnostic disable-next-line: missing-fields
  --     require('neotest').setup {
  --       adapters = {
  --         require 'neotest-golang',
  --       },
  --     }
  --   end,
  -- },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
  -- require 'kickstart.plugins.debug',

  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = 'custom.plugins' },
}, {})

-- make windows equal size after resizing vim pane
local resizeGroup = vim.api.nvim_create_augroup('ResizeGroup', {})
vim.api.nvim_create_autocmd('VimResized', {
  callback = function()
    vim.cmd 'wincmd ='
  end,
  group = resizeGroup,
})

-- [[ Highlight on yank ]]
local yank_highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { timeout = 75 }
  end,
  group = yank_highlight_group,
  pattern = '*',
})

-- [[ Load a persisted session if it exists]]
local persist_group = vim.api.nvim_create_augroup('PersistLoad', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd [[Oil]]
    require('persistence').load()
  end,
  group = persist_group,
  pattern = '*',
})

require 'lsp'
require 'options'
require 'treesitter_setup'
require 'cmp_setup'
require 'keymaps'
require 'telescope_setup'

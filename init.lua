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

local lspHighlightsGroup = vim.api.nvim_create_augroup('LspHighlightsGroup', {})
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    local hl_groups = { 'LspReferenceText', 'LspReferenceRead', 'LspReferenceWrite' }
    for _, g in ipairs(hl_groups) do
      vim.cmd('highlight clear ' .. g)
      vim.cmd('highlight ' .. g .. ' cterm=underline,bold gui=underline,bold')
    end
  end,
  group = lspHighlightsGroup,
})

-- make windows equal size after resizing vim pane
local resizeGroup = vim.api.nvim_create_augroup('ResizeGroup', {})
vim.api.nvim_create_autocmd('VimResized', {
  callback = function()
    vim.cmd 'wincmd ='
  end,
  group = resizeGroup,
})

-- make windows equal size after resizing vim pane
local autodismissNoiceGroup = vim.api.nvim_create_augroup('AutodismissNoice', {})
vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  callback = function()
    pcall(require('noice').cmd, 'dismiss')
  end,
  group = resizeGroup,
})

require('lazy').setup({
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
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
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
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
  {
    'otavioschwanck/arrow.nvim',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    opts = {
      show_icons = true,
      mappings = {
        edit = 'e',
        delete_mode = 'D',
        clear_all_items = 'C',
        toggle = 'S', -- used as save if separate_save_and_remove is true
        open_vertical = 'v',
        open_horizontal = 'x',
        quit = 'q',
        next_item = ']',
        prev_item = '[',
      },
      per_buffer_config = {
        lines = 6, -- Number of lines showed on preview.
      },
      leader_key = "'", -- Recommended to be a single key
      buffer_leader_key = 'm', -- Per Buffer Mappings
      index_keys = 'asdfghjkl',
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
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

-- [[ Highlight on yank ]]
local yank_highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { timeout = 75 }
  end,
  group = yank_highlight_group,
  pattern = '*',
})

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>r', vim.lsp.buf.rename, '[R]ename')
  nmap('<leader>c', vim.lsp.buf.code_action, '[C]ode Action')
  nmap('<leader>lf', vim.lsp.buf.format, 'Format')

  nmap('gd', function()
    require('telescope.builtin').lsp_definitions { show_line = false }
  end, '[G]oto [D]efinition')
  nmap('gr', function()
    require('telescope.builtin').lsp_references { show_line = false }
  end, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<C-m>', vim.lsp.buf.signature_help, 'Signature Documentation')
  -- vim.keymap.set('i', '<C-m>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Documentation' })

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    buffer = bufnr,
    callback = function()
      local filetype = vim.bo[bufnr].filetype
      local tokens = vim.lsp.semantic_tokens.get_at_pos()
      if tokens ~= nil and filetype ~= 'svelte' then
        vim.lsp.buf.document_highlight()
      end
    end,
  })
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  clangd = {},
  gopls = {},
  jdtls = {},
  hls = {},
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  tailwindcss = {},
  html = {},
  ocamllsp = {},
  jsonls = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

require 'options'
require 'treesitter_setup'
require 'cmp_setup'
require 'keymaps'
require 'telescope_setup'

-- ✖»✕
vim.diagnostic.config {
  virtual_text = {
    prefix = '»',
  },
}

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- prevent gopls from triggering pushes
  preselect = 'None',
  completion = {
    -- noselect makes it so that the first item is not selected by default (along with select = false below)
    completeopt = 'menu,menuone,noinsert,noselect',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-j>'] = cmp.mapping(function()
      cmp.select_next_item()
    end, { 'i', 'c' }),
    ['<C-k>'] = cmp.mapping(function()
      cmp.select_prev_item()
    end, { 'i', 'c' }),
    ['<C-u>'] = cmp.mapping(function()
      cmp.scroll_docs(-4)
    end, { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(function()
      cmp.scroll_docs(4)
    end, { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(function()
      cmp.complete {}
    end, { 'i', 'c' }),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<C-n>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-p>'] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
}

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' },
      },
    },
  }),
})

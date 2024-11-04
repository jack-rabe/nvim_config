-- [[ Configure LSP ]]
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

return {
  'stevearc/conform.nvim',
  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'goimports', 'gofumpt' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      heex = { 'mix' },
      elixir = { 'mix' },
      eelixir = { 'mix' },
    },
  },
}

return {
  'stevearc/oil.nvim',
  opts = {
    columns = { 'icon' },
    skip_confirm_for_simple_edits = true,
    keymaps = {
      ['<C-h>'] = false,
      ['<C-l>'] = false,
      ['<C-r>'] = 'actions.refresh',
      ['<C-x>'] = 'actions.select_split',
      ['<M-v>'] = 'actions.select_vsplit',
    },
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 8,
    },
  },
}

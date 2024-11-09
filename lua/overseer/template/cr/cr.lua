return {
  name = 'cr',
  builder = function()
    return {
      cmd = { 'cr' },
      args = { '--autopublish', '--reviewers...' },
      components = { 'on_exit_set_status', 'unique', { 'on_output_quickfix', open = true } },
    }
  end,
  condition = {
    -- TODO in a brazil/peru repo
  },
}

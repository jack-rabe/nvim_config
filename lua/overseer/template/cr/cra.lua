return {
  name = 'cra',
  builder = function()
    return {
      cmd = { 'cr' },
      args = { '--autopublish', '--reviewers...', '--all' },
      components = { { 'on_output_quickfix', open = true }, 'on_exit_set_status' },
    }
  end,
  condition = {
    -- TODO in a brazil/peru repo
  },
}

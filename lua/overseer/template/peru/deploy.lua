return {
  name = 'cdk deploy',
  builder = function()
    return {
      cmd = { 'npx' },
      args = { '--', 'cdk', 'deploy', '--all' },
      components = { 'on_exit_set_status', { 'on_output_quickfix', open = true } },
    }
  end,
  condition = {
    -- TODO in a brazil/peru repo
  },
}

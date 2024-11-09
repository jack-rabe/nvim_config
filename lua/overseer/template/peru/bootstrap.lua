return {
  name = 'cdk bootstrap',
  builder = function()
    return {
      cmd = { 'npx' },
      args = { '--', 'cdk', 'bootstrap' },
      components = { 'on_exit_set_status', 'on_complete_notify' },
    }
  end,
  condition = {
    -- TODO in a brazil/peru repo
  },
}

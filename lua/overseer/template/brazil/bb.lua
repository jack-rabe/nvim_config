return {
  name = 'bb',
  builder = function()
    return {
      cmd = { 'bb' },
      components = { 'on_exit_set_status', 'on_complete_notify' },
    }
  end,
  condition = {
    -- TODO in a brazil/peru repo
  },
}

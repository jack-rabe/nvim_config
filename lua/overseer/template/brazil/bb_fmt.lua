return {
  name = 'bb fmt',
  builder = function()
    return {
      cmd = { 'bb' },
      args = { 'fmt' },
      -- components = { { 'on_output_quickfix', open = true }, 'default' },
      components = { 'on_exit_set_status', 'on_complete_notify' },
    }
  end,
  condition = {
    -- TODO in a brazil/peru repo
  },
}

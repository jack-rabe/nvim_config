return {
    'otavioschwanck/arrow.nvim',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    opts = {
      show_icons = true,
      mappings = {
        edit = 'e',
        delete_mode = 'D',
        clear_all_items = 'C',
        toggle = 'S', -- used as save if separate_save_and_remove is true
        open_vertical = 'v',
        open_horizontal = 'x',
        quit = 'q',
        next_item = ']',
        prev_item = '[',
      },
      window = {
        border = 'none',
      },
      per_buffer_config = {
        lines = 6, -- Number of lines showed on preview.
      },
      leader_key = "'", -- Recommended to be a single key
      buffer_leader_key = 'm', -- Per Buffer Mappings
      index_keys = 'asdfghjkl',
    },
}

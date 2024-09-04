return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    presets = {
      -- bottom_search = true,
      -- lsp_doc_border = true,
    },
    lsp = {
      hover = {
        silent = true,
      },
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
      progress = {
        enabled = false,
      },
    },

    messages = {
      view_search = false, -- view for search count messages. Set to `false` to disable
      view = 'notify', -- default view for messages
      view_error = 'notify', -- view for errors
    },
    commands = {
      history = {
        view = 'popup',
      },
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries!
    'MunifTanjim/nui.nvim',
    --   `nvim-notify` is only needed, if you want to use the notification view. (will mess up cursor renders within zellij)
    --   If not available, we use `mini` as the fallback
    {
      'rcarriga/nvim-notify',
      opts = {
        stages = 'static',
        -- top_down = false
      },
    },
  },
}

-- see https://www.reddit.com/r/neovim/comments/xy0tu1/cmdheight0_recording_macros_message/
local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Recording @' .. recording_register
  end
end

vim.api.nvim_create_autocmd('RecordingEnter', {
  callback = function()
    require('lualine').refresh {
      place = { 'statusline' },
    }
  end,
})

vim.api.nvim_create_autocmd('RecordingLeave', {
  callback = function()
    -- Instead of just calling refresh we need to wait a moment because of the nature of
    -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
    -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
    -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
    -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
    local timer = vim.loop.new_timer()
    timer:start(
      50,
      0,
      vim.schedule_wrap(function()
        require('lualine').refresh {
          place = { 'statusline' },
        }
      end)
    )
  end,
})

-- shows the names of attached lsp and formatting clients
local function get_attached_clients()
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return ''
  end

  local names = {}
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      table.insert(names, client.name)
    end
  end

  local formatters = require('conform').list_formatters()
  for _, f in ipairs(formatters) do
    table.insert(names, f.name)
  end

  if #names == 0 then
    return 'no client attached'
  end
  return table.concat(names, ' | ')
end

return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- See `:help lualine.txt`
  opts = {
    options = {
      component_separators = '|',
      section_separators = '',
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        { 'mode' },
      },
      lualine_b = { 'branch' },
      lualine_c = { 'filename', 'diagnostics', show_macro_recording },
      lualine_x = { get_attached_clients },
      lualine_y = { 'filetype' },
      lualine_z = { 'location' },
    },
  },
}

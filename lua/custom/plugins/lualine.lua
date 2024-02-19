-- see https://www.reddit.com/r/neovim/comments/xy0tu1/cmdheight0_recording_macros_message/
local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    require('lualine').refresh({
      place = { "statusline" },
    })
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
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
        require('lualine').refresh({
          place = { "statusline" },
        })
      end)
    )
  end,
})

local function get_harpoon_files()
  local items = require('harpoon'):list().items
  local filenames = {}
  local keys = { 'a', 's', 'd', 'f' }
  local current_file = vim.fn.expand('%:p')
  for idx, item in pairs(items) do
    if idx > 4 then break end

    local path_in_repo = item.value
    local filename = path_in_repo:match("[^/]+$")
    local file_is_active = current_file:match(".*" .. path_in_repo) ~= nil
    if file_is_active then
      table.insert(filenames, " <" .. keys[idx] .. "> " .. filename)
    else
      table.insert(filenames, " [" .. keys[idx] .. "] " .. filename)
    end
  end
  local res = table.concat(filenames, " | ")
  return res
end

return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      component_separators = '|',
      section_separators = '',
      globalstatus = true
    },
    sections = {
      lualine_a = { 'mode', },
      lualine_b = { 'branch' },
      lualine_c = { 'filename', 'diagnostics', 'diff', show_macro_recording, },
      lualine_x = { get_harpoon_files },
      lualine_y = { 'filetype' },
      lualine_z = { 'location' }
    },
  },
}

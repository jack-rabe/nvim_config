-- telescope
local themes = require('telescope.themes')
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
-- treesitter
local parsers = require('nvim-treesitter.parsers')
-- other
local json = require "json"

local get_interfaces = function()
  local home_dir = vim.loop.os_homedir()
  local file_path = home_dir .. "/.config/nvim/lua/interfaces.json"
  local content = ""
  local lines = vim.fn.readfile(file_path)
  for _, line in ipairs(lines) do
    content = content .. line
  end
  local interfaces = json:decode(content)
  local filtered_interfaces = {}
  for _, i in ipairs(interfaces) do
    -- TODO - right now, I filter out interfaces with no methods
    if #(i.methods) > 0 then
      table.insert(filtered_interfaces, i)
    end
  end
  return filtered_interfaces
end

-- TODO in general, handle errors better
local function get_node_under_cursor()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2] - 1
  local parser = parsers.get_parser()
  if not parser then
    print("Parser not available for current buffer")
    return
  end
  local root = parser:parse()[1]:root()
  local node = root:named_descendant_for_range(row, col, row, col)

  if node then
    local start_row, start_col, _, end_col = node:range()
    local node_text = vim.api.nvim_buf_get_text(0, start_row, start_col, start_row, end_col, {})[1]
    return node_text, node:type()
  else
    print("No Treesitter node found under cursor")
    return
  end
end

local add_methods = function(interface)
  local node, node_type = get_node_under_cursor()
  -- TODO make treesitter checks that it's a type_identifier __for a struct__
  if node_type ~= "type_identifier" then
    print("not a valid Treesitter node")
    return
  end
  local lines = {}
  for _, m in ipairs(interface.methods) do
    -- TOOD insert after by using treesitter
    local lower_first_char = string.lower(string.sub(node, 1, 1))
    table.insert(lines, "func (" .. lower_first_char .. " " .. node .. ") " .. m .. " {")
    table.insert(lines, "}")
  end
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row_to_insert = (cursor[1] - 1) - 1
  vim.api.nvim_buf_set_lines(0, row_to_insert, row_to_insert, false, lines)
end

local go_interfaces = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Interfaces",
    finder = finders.new_table {
      results = get_interfaces(),
      entry_maker = function(entry)
        return {
          -- TODO make this a fucntion for performance
          value = entry,
          display = entry.package .. '.' .. entry.name,
          ordinal = entry.package .. '.' .. entry.name,
        }
      end
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selected_interface = action_state.get_selected_entry().value
        add_methods(selected_interface)
      end)
      return true
    end,
  }):find()
end

vim.keymap.set('n', '<leader>si', function()
  go_interfaces(themes.get_dropdown {
    layout_config = {
      center = {
        anchor = "N",
      },
    }
  })
end)

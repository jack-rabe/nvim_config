local themes = require('telescope.themes')
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local json = require "json"

local get_interfaces = function()
  local file = io.open("interfaces.json", "r")
  if not file then return nil end
  local content = file:read "*a"
  file:close()
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

local add_methods = function(interface)
  local lines = {}
  for _, m in ipairs(interface.methods) do
    local method = m .. "{"
    table.insert(lines, method)
    table.insert(lines, "}")
  end
  vim.api.nvim_put(lines, "", true, true)
end


local go_interfaces = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Interfaces",
    finder = finders.new_table {
      results = get_interfaces(),
      entry_maker = function(entry)
        return {
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

go_interfaces(themes.get_dropdown {
  layout_config = {
    center = {
      anchor = "N",
    },
  }
})

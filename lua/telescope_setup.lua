-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require('telescope.actions')
local builtins = require('telescope.builtin')
local themes = require('telescope.themes')

require('telescope').setup {
  extensions = {
    ["ui-select"] = {
      themes.get_dropdown {}
    }
  },
  defaults = {
    layout_config = { horizontal = { prompt_position = 'top', height = .95, width = .95, preview_width = .4 } },
    sorting_strategy = 'ascending',
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
      n = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
  },
  pickers = {
    command_history = {
      theme = "ivy",
    },
    builtin = {
      theme = "ivy",
    },
    registers = {
      theme = "ivy",
    }
  }
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require("telescope").load_extension, "ui-select")

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    builtins.live_grep {
      search_dirs = { git_root },
    }
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

local function telescope_live_grep_open_files()
  builtins.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end


local nmap = function(keys, func, desc)
  if desc then
    desc = desc
  end
  vim.keymap.set('n', '<leader>' .. keys, func, { desc = desc })
end

nmap('?', builtins.oldfiles, '[?] Find recently opened files')
nmap('f', builtins.git_files, 'Search Git [F]iles')
nmap('sb', builtins.buffers, 'Find existing buffers')
nmap('so', telescope_live_grep_open_files, '[S]earch in [O]pen Files')
nmap('st', builtins.builtin, '[S]earch [T]elescope')
nmap('sf', builtins.find_files, '[S]earch [F]iles')
nmap('sh', builtins.help_tags, '[S]earch [H]elp')
nmap('sw', builtins.grep_string, '[S]earch current [W]ord')
nmap('sg', builtins.live_grep, '[S]earch by [G]rep')
nmap('sG', ':LiveGrepGitRoot<cr>', '[S]earch by [G]rep on Git Root')
nmap('sd', builtins.diagnostics, '[S]earch [D]iagnostics')
nmap('sr', builtins.registers, '[S]earch [R]egisters')
nmap('ss', builtins.lsp_document_symbols, 'Document [S]ymbols')
nmap('sc', builtins.command_history, '[C]ommand History')
nmap('sy', builtins.lsp_dynamic_workspace_symbols, 'Workspace Symbols')
nmap('su', builtins.resume, '[S]earch Resume')
nmap('<space>', builtins.current_buffer_fuzzy_find, 'Current buffer fuzzy find')
nmap('sH', function() builtins.find_files({ hidden = true }) end, 'Search [H]idden Files')

nmap('gb', builtins.git_branches, '[G]it [B]ranches')
nmap('gs', builtins.git_status, '[G]it [S]tatus')

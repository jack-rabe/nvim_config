-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
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
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

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

local tele_bi = require('telescope.builtin')
-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    tele_bi.live_grep {
      search_dirs = { git_root },
    }
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

local function telescope_live_grep_open_files()
  tele_bi.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

vim.keymap.set('n', '<leader>?', tele_bi.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', tele_bi.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>so', telescope_live_grep_open_files, { desc = '[S]earch in [O]pen Files' })
vim.keymap.set('n', '<leader>f', tele_bi.git_files, { desc = 'Search Git [F]iles' })
vim.keymap.set('n', '<leader>st', tele_bi.builtin, { desc = '[S]earch [T]elescope' })
vim.keymap.set('n', '<leader>sf', tele_bi.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', tele_bi.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', tele_bi.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', tele_bi.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', tele_bi.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', tele_bi.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>ss', tele_bi.lsp_document_symbols, { desc = 'Document [S]ymbols' })
vim.keymap.set('n', '<leader>sc', tele_bi.command_history, { desc = '[C]ommand History' })
vim.keymap.set('n', '<leader>sy', tele_bi.lsp_dynamic_workspace_symbols, { desc = 'Workspace Symbols' })

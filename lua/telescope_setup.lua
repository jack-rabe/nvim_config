local actions = require 'telescope.actions'
local builtins = require 'telescope.builtin'
local themes = require 'telescope.themes'

require('telescope').setup {
  extensions = {
    ['ui-select'] = {
      themes.get_dropdown {
        layout_config = {
          center = {
            anchor = 'N',
          },
        },
      },
    },
  },
  defaults = {
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        height = 0.8,
        width = 0.95,
        preview_width = 0.5,
      },
      center = {
        anchor = 'S',
        width = 0.7,
      },
    },
    sorting_strategy = 'ascending',
    mappings = {
      i = {
        -- TODO - prev/next history mappings
        ['<C-n>'] = actions.move_selection_next,
        ['<C-p>'] = actions.move_selection_previous,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-a>'] = actions.send_to_qflist + actions.open_qflist,
        ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
      },
      n = {
        ['<C-n>'] = actions.move_selection_next,
        ['<C-p>'] = actions.move_selection_previous,
        ['<C-a>'] = actions.send_to_qflist + actions.open_qflist,
        ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
  },
  pickers = {
    lsp_references = {
      layout_strategy = 'center',
    },
    diagnostics = {
      layout_strategy = 'center',
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local nmap = function(keys, func, desc)
  if desc then
    desc = desc
  end
  vim.keymap.set('n', '<leader>' .. keys, func, { desc = desc })
end

nmap('?', builtins.oldfiles, '[?] Find recently opened files')
nmap('f', function()
  if not pcall(builtins.git_files) then
    builtins.find_files()
  end
end, 'Search Git [F]iles')
nmap('sb', builtins.buffers, 'Find existing buffers')
nmap('st', builtins.builtin, '[S]earch [T]elescope')
nmap('sh', builtins.help_tags, '[S]earch [H]elp')
nmap('sw', builtins.grep_string, '[S]earch current [W]ord')
nmap('sg', builtins.live_grep, '[S]earch by [G]rep')
nmap('sd', builtins.diagnostics, '[S]earch [D]iagnostics')
nmap('ss', builtins.lsp_document_symbols, 'Document [S]ymbols')
nmap('sc', builtins.commands, '[S]earch [C]ommand')
vim.keymap.set('n', '<leader>:', builtins.command_history, { desc = 'Command History' })
nmap('sy', builtins.lsp_dynamic_workspace_symbols, 'Workspace Symbols')
nmap('sr', builtins.resume, '[S]earch Resume')
nmap('<space>', builtins.current_buffer_fuzzy_find, 'Current buffer fuzzy find')
nmap('sf', function()
  builtins.find_files { hidden = true }
end, 'Search [H]idden Files')
nmap('sn', function()
  require('telescope').extensions.notify.notify {}
end, 'Search [N]otify')

nmap('gb', builtins.git_branches, '[G]it [B]ranches')
nmap('gs', builtins.git_status, '[G]it [S]tatus')

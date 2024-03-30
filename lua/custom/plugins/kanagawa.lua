return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colo 'kanagawa'
    vim.cmd [[highlight LineNr guibg=guibg=#1f1f28]]
    vim.cmd [[highlight SignColumn guibg=guibg=#1f1f28]]
    vim.cmd [[ highlight GitSignsAdd guibg=#1f1f28 ]]
    vim.cmd [[ highlight GitSignsChange guibg=#1f1f28 ]]
    vim.cmd [[ highlight GitSignsDelete guibg=#1f1f28 ]]
  end,
}

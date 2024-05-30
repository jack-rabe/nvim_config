return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colo 'kanagawa'
    vim.cmd [[highlight clear NoiceCmdlineTitle]]
    vim.cmd [[highlight link NoiceCmdlinePopupBorder Normal]]
    vim.cmd [[highlight link NoiceCmdlinePopupTitle Normal]]
    vim.cmd [[highlight NoiceCmdlinePopupTitle cterm=bold gui=bold]]

    -- TODO diagnostics
    -- TODO Noice search bar
    local groups = { 'LineNr', 'SignColumn', 'GitSignsAdd', 'GitSignsChange', 'GitSignsDelete', 'FloatBorder', 'NormalFloat' }
    for _, g in ipairs(groups) do
      vim.cmd('highlight ' .. g .. ' guibg=guibg=#1f1f28')
    end
  end,
}

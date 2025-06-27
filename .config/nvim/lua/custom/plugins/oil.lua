-- oil
-- https://github.com/stevearc/oil.nvim
--
return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup()
    -- Set keybinding to open Oil with the minus key
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open Oil file explorer' })
  end,
}

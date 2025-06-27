return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {
      global_settings = {
        save_on_toggle = false, -- Don't save marks on toggle
        save_on_change = true, -- Save on every change
        enter_on_sendcmd = false, -- Don't auto-enter terminal commands
        tmux_autoclose_windows = false, -- Keep tmux windows open
        excluded_filetypes = { 'harpoon' }, -- Exclude harpoon menu
        mark_branch = false, -- Don't tie marks to git branches
        tabline = false, -- Disable tabline integration
      },
    }

    -- Keybindings for QWERTY
    local function map(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { desc = desc, noremap = true, silent = true })
    end

    -- Add file to harpoon list
    map('<leader>a', function()
      harpoon:list():add()
    end, 'Harpoon: Add file')
    -- Open harpoon menu
    map('<leader>m', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, 'Harpoon: Toggle menu')
    -- Navigate to files (1-4)
    map('<C-h>', function()
      harpoon:list():select(1)
    end, 'Harpoon: Go to file 1')
    map('<C-j>', function()
      harpoon:list():select(2)
    end, 'Harpoon: Go to file 2')
    map('<C-k>', function()
      harpoon:list():select(3)
    end, 'Harpoon: Go to file 3')
    map('<C-l>', function()
      harpoon:list():select(4)
    end, 'Harpoon: Go to file 4')
    -- Cycle through harpooned files
    map('<C-S-P>', function()
      harpoon:list():prev()
    end, 'Harpoon: Previous file')
    map('<C-S-N>', function()
      harpoon:list():next()
    end, 'Harpoon: Next file')
    -- Telescope integration
    map('<C-e>', function()
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end
        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table { results = file_paths },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end
      toggle_telescope(harpoon:list())
    end, 'Harpoon: Telescope menu')
  end,
}

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    local logo = [[
  ██████████████████████████████████████████████
  █▌                                          ▐█
  █▌                                          ▐█
  █▌  ____   ____    ____   ____.__           ▐█
  █▌  \   \ /   /____\   \ /   /|__| _____    ▐█
  █▌   \   Y   /  ___/\   Y   / |  |/     \   ▐█
  █▌    \     /\___ \  \     /  |  |  Y Y  \  ▐█
  █▌     \___//____  >  \___/   |__|__|_|  /  ▐█
  █▌               \/                    \/   ▐█
  █▌                                          ▐█
  █▌                                          ▐█
  ██████████████████████████████████████████████
      ]]
    logo = string.rep('\n', 8) .. logo .. '\n\n'
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        header = vim.split(logo, '\n'),
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Config',
            group = 'DiagnosticHint',
            action = [[require("kickstart.utils.telescope").config_files()()]],
            key = 'c',
          },
        },
        packages = { enable = true },
        project = { enable = true, action = 'require("persistence").load()' },
        mru = { limit = 10, icon = 'your icon', label = 'Recent Files', cwd_only = false },
        footer = { '󰣙 Do. Or do not. There is no try. 󰣙' },
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}

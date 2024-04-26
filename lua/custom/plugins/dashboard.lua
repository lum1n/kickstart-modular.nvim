return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    local logo = [[
 ____      ____          ______   ____      ____  ____      ______  _______   
|    |    |    |     ___|\     \ |    |    |    ||    |    |      \/       \  
|    |    |    |    |    |\     \|    |    |    ||    |   /          /\     \ 
|    |    |    |    |    |/____/||    |    |    ||    |  /     /\   / /\     |
|    |    |    | ___|    \|   | ||    |    |    ||    | /     /\ \_/ / /    /|
|    |    |    ||    \    \___|/ |    |    |    ||    ||     |  \|_|/ /    / |
|\    \  /    /||    |\     \    |\    \  /    /||    ||     |       |    |  |
| \ ___\/___ / ||\ ___\|_____|   | \ ___\/___ / ||____||\____\       |____|  /
 \ |   ||   | / | |    |     |    \ |   ||   | / |    || |    |      |    | / 
  \|___||___|/   \|____|_____|     \|___||___|/  |____| \|____|      |____|/  
    \(    )/        \(    )/         \(    )/      \(      \(          )/     
     '    '          '    '           '    '        '       '          '      
      ]]
    logo = string.rep('\n', 8) .. logo .. '\n\n'
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        header = vim.split(logo, '\n'),
        -- week_header = {
        --   enable = true,
        -- },
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
          -- {
          --   desc = ' Apps',
          --   group = 'DiagnosticHint',
          --   action = 'Telescope app',
          --   key = 'a',
          -- },
          -- {
          --   desc = ' dotfiles',
          --   group = 'Number',
          --   action = 'Telescope dotfiles',
          --   key = 'd',
          -- },
        },
        packages = { enable = true },
        project = { enable = true, action = 'Telescope find_files cwd=' },
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}

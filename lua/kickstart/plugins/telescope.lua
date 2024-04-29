-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = true },
    },
    config = function(_, opts)
      require('telescope').setup {
        defaults = {
          vimgrep_arguments = {
            'rg',
            '-L',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
          },
          prompt_prefix = '   ',
          selection_caret = '  ',
          entry_prefix = '  ',
          initial_mode = 'normal',
          selection_strategy = 'reset',
          sorting_strategy = 'ascending',
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          file_sorter = require('telescope.sorters').get_fuzzy_file,
          file_ignore_patterns = { 'node_modules' },
          generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
          path_display = { 'truncate' },
          winblend = 0,
          border = {},
          borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
          color_devicons = true,
          set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
          file_previewer = require('telescope.previewers').vim_buffer_cat.new,
          grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
          qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
          -- Developer configurations: Not meant for general override
          buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
          mappings = {
            n = { ['q'] = require('telescope.actions').close },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local lazyvimTelescope = require 'kickstart.utils.telescope'
      -- local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>,', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>', { desc = 'Switch Buffer' })
      vim.keymap.set('n', '<leader>/', lazyvimTelescope.telescope 'live_grep', { desc = 'Grep (Root Dir)' })
      vim.keymap.set('n', '<leader>:', '<cmd>Telescope command_history<cr>', { desc = 'Command History' })
      vim.keymap.set('n', '<leader><space>', lazyvimTelescope.telescope 'files', { desc = 'Find Files (Root Dir)' })
      -- find
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>', { desc = 'Buffers' })
      vim.keymap.set('n', '<leader>fc', lazyvimTelescope.config_files(), { desc = 'Find Config File' })
      vim.keymap.set('n', '<leader>ff', lazyvimTelescope.telescope 'files', { desc = 'Find Files (Root Dir)' })
      vim.keymap.set('n', '<leader>fF', lazyvimTelescope.telescope('files', { cwd = false }), { desc = 'Find Files (cwd)' })
      vim.keymap.set('n', '<leader>fg', '<cmd>Telescope git_files<cr>', { desc = 'Find Files (git-files)' })
      vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = 'Recent' })
      vim.keymap.set('n', '<leader>fR', lazyvimTelescope.telescope('oldfiles', { cwd = vim.uv.cwd() }), { desc = 'Recent (cwd)' })
      -- git
      vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<CR>', { desc = 'Commits' })
      vim.keymap.set('n', '<leader>gs', '<cmd>Telescope git_status<CR>', { desc = 'Status' })
      -- search
      vim.keymap.set('n', '<leader>s"', '<cmd>Telescope registers<cr>', { desc = 'Registers' })
      vim.keymap.set('n', '<leader>sa', '<cmd>Telescope autocommands<cr>', { desc = 'Auto Commands' })
      vim.keymap.set('n', '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { desc = 'Buffer' })
      vim.keymap.set('n', '<leader>sc', '<cmd>Telescope command_history<cr>', { desc = 'Command History' })
      vim.keymap.set('n', '<leader>sC', '<cmd>Telescope commands<cr>', { desc = 'Commands' })
      vim.keymap.set('n', '<leader>sd', '<cmd>Telescope diagnostics bufnr=0<cr>', { desc = 'Document Diagnostics' })
      vim.keymap.set('n', '<leader>sD', '<cmd>Telescope diagnostics<cr>', { desc = 'Workspace Diagnostics' })
      vim.keymap.set('n', '<leader>sg', lazyvimTelescope.telescope 'live_grep', { desc = 'Grep (Root Dir)' })
      vim.keymap.set('n', '<leader>sG', lazyvimTelescope.telescope('live_grep', { cwd = false }), { desc = 'Grep (cwd)' })
      vim.keymap.set('n', '<leader>sh', '<cmd>Telescope help_tags<cr>', { desc = 'Help Pages' })
      vim.keymap.set('n', '<leader>sH', '<cmd>Telescope highlights<cr>', { desc = 'Search Highlight Groups' })
      vim.keymap.set('n', '<leader>sk', '<cmd>Telescope keymaps<cr>', { desc = 'Key Maps' })
      vim.keymap.set('n', '<leader>sM', '<cmd>Telescope man_pages<cr>', { desc = 'Man Pages' })
      vim.keymap.set('n', '<leader>sm', '<cmd>Telescope marks<cr>', { desc = 'Jump to Mark' })
      vim.keymap.set('n', '<leader>so', '<cmd>Telescope vim_options<cr>', { desc = 'Options' })
      vim.keymap.set('n', '<leader>sR', '<cmd>Telescope resume<cr>', { desc = 'Resume' })
      vim.keymap.set('n', '<leader>sw', lazyvimTelescope.telescope('grep_string', { word_match = '-w' }), { desc = 'Word (Root Dir)' })
      vim.keymap.set('n', '<leader>sW', lazyvimTelescope.telescope('grep_string', { cwd = false, word_match = '-w' }), { desc = 'Word (cwd)' })
      vim.keymap.set('v', '<leader>sw', lazyvimTelescope.telescope 'grep_string', { desc = 'Selection (Root Dir)' })
      vim.keymap.set('v', '<leader>sW', lazyvimTelescope.telescope('grep_string', { cwd = false }), { desc = 'Selection (cwd)' })
      vim.keymap.set('n', '<leader>uC', lazyvimTelescope.telescope('colorscheme', { enable_preview = true }), { desc = 'Colorscheme with Preview' })
      vim.keymap.set('n', '<leader>ss', function()
        require('telescope.builtin').lsp_document_symbols {
          symbols = require('kickstart.utils.div').get_kind_filter(),
        }
      end, { desc = 'Goto Symbol' })
      vim.keymap.set('n', '<leader>sS', function()
        require('telescope.builtin').lsp_dynamic_workspace_symbols {
          symbols = require('kickstart.utils.div').get_kind_filter(),
        }
      end, { desc = 'Goto Symbol (Workspace)' })
      -- See `:help telescope.builtin`
      -- vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      -- vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      -- vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      -- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      -- vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      -- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      -- vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      -- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      -- vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      --
      -- vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<CR>', { desc = 'Commits' })
      --
      -- -- Slightly advanced example of overriding default behavior and theme
      -- vim.keymap.set('n', '<leader>/', function()
      --   -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      --   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      --     winblend = 10,
      --     previewer = false,
      --   })
      -- end, { desc = '[/] Fuzzily search in current buffer' })
      --
      -- -- It's also possible to pass additional configuration options.
      -- --  See `:help telescope.builtin.live_grep()` for information about particular keys
      -- vim.keymap.set('n', '<leader>s/', function()
      --   builtin.live_grep {
      --     grep_open_files = true,
      --     prompt_title = 'Live Grep in Open Files',
      --   }
      -- end, { desc = '[S]earch [/] in Open Files' })
      --
      -- -- Shortcut for searching your Neovim configuration files
      -- vim.keymap.set('n', '<leader>sn', function()
      --   builtin.find_files { cwd = vim.fn.stdpath 'config' }
      -- end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et

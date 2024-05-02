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
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>,', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>', { desc = 'Switch Buffer' })
      vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Grep (Root Dir)' })
      vim.keymap.set('n', '<leader>:', builtin.command_history, { desc = 'Command History' })
      vim.keymap.set('n', '<leader><space>', lazyvimTelescope.telescope 'files', { desc = 'Find Files (Root Dir)' })
      -- find
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>', { desc = 'Buffers' })
      vim.keymap.set('n', '<leader>fc', lazyvimTelescope.config_files(), { desc = 'Find Config File' })
      vim.keymap.set('n', '<leader>ff', lazyvimTelescope.telescope 'files', { desc = 'Find Files (Root Dir)' })
      vim.keymap.set('n', '<leader>fF', lazyvimTelescope.telescope('files', { cwd = false }), { desc = 'Find Files (cwd)' })
      vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Find Files (git-files)' })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent' })
      vim.keymap.set('n', '<leader>fR', lazyvimTelescope.telescope('oldfiles', { cwd = vim.uv.cwd() }), { desc = 'Recent (cwd)' })
      -- git
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Commits' })
      vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Status' })
      -- search
      vim.keymap.set('n', '<leader>s"', builtin.registers, { desc = 'Registers' })
      vim.keymap.set('n', '<leader>sa', builtin.autocommands, { desc = 'Auto Commands' })
      vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, { desc = 'Buffer' })
      vim.keymap.set('n', '<leader>sc', builtin.command_history, { desc = 'Command History' })
      vim.keymap.set('n', '<leader>sC', builtin.commands, { desc = 'Commands' })
      vim.keymap.set('n', '<leader>sd', '<cmd>Telescope diagnostics bufnr=0<cr>', { desc = 'Document Diagnostics' })
      vim.keymap.set('n', '<leader>sD', builtin.diagnostics, { desc = 'Workspace Diagnostics' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Grep (Root Dir)' })
      vim.keymap.set('n', '<leader>sG', lazyvimTelescope.telescope('live_grep', { cwd = false }), { desc = 'Grep (cwd)' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help Pages' })
      vim.keymap.set('n', '<leader>sH', builtin.highlights, { desc = 'Search Highlight Groups' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Key Maps' })
      vim.keymap.set('n', '<leader>sM', builtin.man_pages, { desc = 'Man Pages' })
      vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = 'Jump to Mark' })
      vim.keymap.set('n', '<leader>so', builtin.vim_options, { desc = 'Options' })
      vim.keymap.set('n', '<leader>sR', builtin.resume, { desc = 'Resume' })
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
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et

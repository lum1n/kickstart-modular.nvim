return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]indow', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>q'] = { name = '[Q]uit', _ = 'which_key_ignore' },
        ['<leader>u'] = { name = '[U]i', _ = 'which_key_ignore' },
        ['<leader>x'] = { name = 'Diagnostics', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = '[F]ind', _ = 'which_key_ignore' },
      }
      -- visual mode
      -- require('which-key').register({
      --   ['<leader>h'] = { 'Git [H]unk' },
      -- }, { mode = 'v' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et

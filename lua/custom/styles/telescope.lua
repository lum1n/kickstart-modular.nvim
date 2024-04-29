local colors = {
  white = '#c0caf5',
  darker_black = '#16161e',
  black = '#1a1b26', --  nvim bg
  black2 = '#1f2336',
  one_bg = '#24283b',
  one_bg2 = '#414868',
  one_bg3 = '#353b45',
  grey = '#40486a',
  grey_fg = '#565f89',
  grey_fg2 = '#4f5779',
  light_grey = '#545c7e',
  red = '#f7768e',
  baby_pink = '#DE8C92',
  pink = '#ff75a0',
  line = '#32333e', -- for lines like vertsplit
  green = '#9ece6a',
  vibrant_green = '#73daca',
  nord_blue = '#80a8fd',
  blue = '#7aa2f7',
  yellow = '#e0af68',
  sun = '#EBCB8B',
  purple = '#bb9af7',
  dark_purple = '#9d7cd8',
  teal = '#1abc9c',
  orange = '#ff9e64',
  cyan = '#7dcfff',
  statusline_bg = '#1d1e29',
  lightbg = '#32333e',
  pmenu_bg = '#7aa2f7',
  folder_bg = '#7aa2f7',
}

local hlgroups = {

  TelescopePromptPrefix = {
    fg = colors.red,
    bg = colors.black2,
  },

  TelescopeNormal = { bg = colors.darker_black },

  TelescopePreviewTitle = {
    fg = colors.black,
    bg = colors.green,
  },

  TelescopePromptTitle = {
    fg = colors.black,
    bg = colors.red,
  },

  TelescopeSelection = { bg = colors.black2, fg = colors.white },
  TelescopeResultsDiffAdd = { fg = colors.green },
  TelescopeResultsDiffChange = { fg = colors.yellow },
  TelescopeResultsDiffDelete = { fg = colors.red },

  TelescopeMatching = { bg = colors.one_bg, fg = colors.blue },
}

local styles = {
  borderless = {
    TelescopeBorder = { fg = colors.darker_black, bg = colors.darker_black },
    TelescopePromptBorder = { fg = colors.black2, bg = colors.black2 },
    TelescopePromptNormal = { fg = colors.white, bg = colors.black2 },
    TelescopeResultsTitle = { fg = colors.darker_black, bg = colors.darker_black },
    TelescopePromptPrefix = { fg = colors.red, bg = colors.black2 },
  },

  bordered = {
    TelescopeBorder = { fg = colors.one_bg3 },
    TelescopePromptBorder = { fg = colors.one_bg3 },
    TelescopeResultsTitle = { fg = colors.black, bg = colors.green },
    TelescopePreviewTitle = { fg = colors.black, bg = colors.blue },
    TelescopePromptPrefix = { fg = colors.red, bg = colors.black },
    TelescopeNormal = { bg = colors.black },
    TelescopePromptNormal = { bg = colors.black },
  },
}

local result = vim.tbl_deep_extend('force', hlgroups, styles)

return result

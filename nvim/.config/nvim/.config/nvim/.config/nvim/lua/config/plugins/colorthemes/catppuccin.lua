return {
  'catppuccin/nvim',
  name = 'catpuccin',
  priority = 1000,
  lazy = false,
  config = function()
    require('catppuccin').setup {
      auto_integrations = true,
      flavour = 'macchiato',
      float = {
        transparent = true,
        solid = true,
      },
      -- dim_inactive = {
      --   enabled = true,
      --   shade = 'light',
      --   percentage = 0.05,
      -- },
      transparent_background = true,
      -- term_colors = true,
      default_integrations = false,
      styles = {
        comments = { 'italic' },
        keywords = { 'bold' },
        functions = { 'bold', 'italic' },
        conditionals = { 'italic' },
      },
      integrations = {
        -- treesitter = true,
        blink_cmp = { style = 'bordered' },
        gitsigns = true,
        mason = true,
        neotree = true,
        -- native_lsp = true,
        nvim_surround = true,
        treesitter = true,
        treesitter_context = true,
        telescope = true,
        which_key = true,
      },
      custom_highlights = function(colors)
        return {
          -- Floating window styling
          NormalFloat = { bg = colors.crust },
          FloatBorder = { bg = colors.mantle, fg = colors.overlay0 },

          -- Line numbers
          -- LineNr = { fg = colors.surface1 },        -- All line numbers (default color)
          -- LineNrAbove = { fg = colors.surface0 },   -- Line numbers above cursor
          -- LineNrBelow = { fg = colors.surface0 },   -- Line numbers below cursor
          -- CursorLineNr = { fg = colors.peach, style = { 'bold' } }, -- Current line number

          -- Alternative colors you can try:
          LineNr = { fg = colors.overlay0 }, -- Slightly brighter
          LineNrAbove = { fg = colors.surface2 }, -- More visible above/below
          LineNrBelow = { fg = colors.surface2 },
          CursorLineNr = { fg = colors.peach, style = { 'bold' } }, -- Blue current line

          -- Gitsigns styling
          GitSignsAdd = { fg = colors.green },
          GitSignsChange = { fg = colors.yellow },
          GitSignsDelete = { fg = colors.red },
          GitSignsAddNr = { fg = colors.green },
          GitSignsChangeNr = { fg = colors.yellow },
          GitSignsDeleteNr = { fg = colors.red },
          GitSignsAddLn = { bg = colors.green, fg = colors.base },
          GitSignsChangeLn = { bg = colors.yellow, fg = colors.base },
          GitSignsDeleteLn = { bg = colors.red, fg = colors.base },

          -- Diff colors in preview windows - Enhanced for clarity
          -- Option 1: Bold and clear (current)
          DiffAdd = { bg = colors.green, fg = colors.base, style = { 'bold' } },
          DiffChange = { bg = colors.yellow, fg = colors.base, style = { 'bold' } },
          DiffDelete = { bg = colors.red, fg = colors.base, style = { 'bold' } },
          DiffText = { bg = colors.peach, fg = colors.base, style = { 'bold' } },

          -- Option 2: Subtle with border highlighting (uncomment to use instead)
          -- DiffAdd = { bg = colors.surface0, fg = colors.text, style = {} },
          -- DiffChange = { bg = colors.surface0, fg = colors.text, style = {} },
          -- DiffDelete = { bg = colors.surface0, fg = colors.overlay0, style = { "strikethrough" } },
          -- DiffText = { bg = colors.surface1, fg = colors.text, style = { "underline" } },

          -- Diff line numbers and signs
          DiffAddSign = { fg = colors.green },
          DiffChangeSign = { fg = colors.yellow },
          DiffDeleteSign = { fg = colors.red },
        }
      end,
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}

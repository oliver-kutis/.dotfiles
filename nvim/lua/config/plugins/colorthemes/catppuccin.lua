return {
	"catppuccin/nvim",
	name = "catpuccin",
	priority = 1000,
	lazy = false,
	config = function()
		require("catppuccin").setup({
			auto_integrations = true,
			flavour = "macchiato",
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
				comments = { "italic" },
				keywords = { "bold" },
				functions = { "bold", "italic" },
				conditionals = { "italic" },
			},
			integrations = {
				-- treesitter = true,
				blink_cmp = { style = "bordered" },
				cmp = true,
				gitsigns = true,
				mason = true,
				neotree = true,
				noice = true,
				-- native_lsp = true,
				nvim_surround = true,
				treesitter = true,
				treesitter_context = true,
				telescope = true,
				which_key = true,
				diffview = true,
			},
			custom_highlights = function(colors)
				return {
					-- Floating window styling
					NormalFloat = { bg = colors.base },
					FloatBorder = { bg = colors.base, fg = colors.blue },
					FloatTitle = { fg = colors.blue, bg = colors.base, bold = true },

					-- Window separators - muted blue accent
					WinSeparator = { fg = colors.blue },

					-- Line numbers with Catppuccin colors
					LineNr = { fg = colors.overlay0 },
					CursorLineNr = { fg = colors.mauve, bold = true },
					-- CursorLine = { bg = colors.surface0 },
					-- Gitsigns
					GitSignsAdd = { fg = colors.green },
					GitSignsChange = { fg = colors.yellow },
					GitSignsDelete = { fg = colors.red },

					-- Diff colors
					DiffAdd = { bg = colors.green, fg = colors.base },
					DiffChange = { bg = colors.yellow, fg = colors.base },
					DiffDelete = { bg = colors.red, fg = colors.base },
					DiffText = { bg = colors.peach, fg = colors.base, bold = true },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}

-- base - #24273a (background)
-- mantle - #1e2030 (darker background)
-- crust - #181926 (darkest background)
-- Surface Colors:

-- surface0 - #363a4f (subtle highlight)
-- surface1 - #494d64 (more visible highlight)
-- surface2 - #5b6078 (even more visible)
-- Overlay Colors:

-- overlay0 - #6e738d (muted text)
-- overlay1 - #8087a2 (slightly brighter)
-- overlay2 - #939ab7 (even brighter)
-- Text Colors:

-- text - #cad3f5 (main text)
-- subtext0 - #a5adcb (dimmed text)
-- subtext1 - #b8c0e0 (slightly dimmed)
-- Accent Colors:

-- rosewater - #f4dbd6
-- flamingo - #f0c6c6
-- pink - #f5bde6
-- mauve - #c6a0f6 (purple)
-- red - #ed8796
-- maroon - #ee99a0
-- peach - #f5a97f (orange)
-- yellow - #eed49f
-- green - #a6da95
-- teal - #8bd5ca
-- sky - #91d7e3
-- sapphire - #7dc4e4
-- blue - #8aadf4
-- lavender - #b7bdf8 (light purple/blue)

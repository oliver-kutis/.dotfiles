-- return {
-- 	-- "folke/tokyonight.nvim",
-- 	"EdenEast/nightfox.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		-- vim.cmd("colorscheme tokyonight")
-- 		require("nightfox").setup({
-- 			options = {
-- 				transparent = true,
-- 			},
-- 		})
--
-- 		vim.cmd("colorscheme nightfox")
-- 	end,
--
local M = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		require("catppuccin").setup({
			-- flavour = true and "mocha" or "machiatto",
			flavour = "macchiato",
			transparent_background = true,
			term_colors = true,
			default_integrations = false,
			styles = {
				keywords = { "bold" },
				functions = { "italic" },
				comments = { "italic" },
				contitionals = { "italic" },
			},
			integrations = {
				nvimtree = true,
				treesitter = true,
				telescope = { enabled = true, stule = "nvchad" },
				lsp_trouble = true,
				cmp = true,
				copilot_vim = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
				},
				gitsigns = true,
				mason = true,
				which_key = true,
			},
			-- custom_highlights = function(colors)
			-- 	return {
			-- 		PanelHeading = {
			-- 			fg = colors.lavender,
			-- 			bg = true and colors.none or colors.crust,
			-- 			style = { "bold", "italic" },
			-- 		},
			-- 		-- lazy.nvim
			-- 		LazyH1 = {
			-- 			bg = true and colors.none or colors.peach,
			-- 			fg = true and colors.lavender or colors.base,
			-- 			style = { "bold" },
			-- 		},
			-- 		LazyButton = {
			-- 			bg = colors.none,
			-- 			fg = true and colors.overlay0 or colors.subtext0,
			-- 		},
			-- 		LazyButtonActive = {
			-- 			bg = true and colors.none or colors.overlay1,
			-- 			fg = true and colors.lavender or colors.base,
			-- 			style = { "bold" },
			-- 		},
			-- 		LazySpecial = { fg = colors.green },
			--
			-- 		FloatBorder = {
			-- 			fg = true and colors.blue or colors.mantle,
			-- 			bg = true and colors.none or colors.mantle,
			-- 		},
			--
			-- 		FloatTitle = {
			-- 			fg = true and colors.lavender or colors.base,
			-- 			bg = true and colors.none or colors.lavender,
			-- 		},
			-- 	}
			-- end,
		})
		vim.cmd.colorscheme("catppuccin")
		-- local palette = require("catpuccin.palletes").get_palette()
		-- Mo.C.filling_pigments(palette)
	end,
}

return M

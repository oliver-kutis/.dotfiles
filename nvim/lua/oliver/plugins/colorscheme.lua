-- return {
-- 	"shaunsingh/nord.nvim",
-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
-- 	priority = 1000, -- make sure to load this before all the other start plugins
-- 	config = function()
-- 		-- Example config in lua
-- 		vim.g.nord_contrast = true -- Make sidebars and popup menus like nvim-tree and telescope have a different background
-- 		vim.g.nord_borders = false -- Enable the border between verticaly split windows visable
-- 		vim.g.nord_disable_background = true -- Disable the setting of background color so that NeoVim can use your terminal background
-- 		vim.g.set_cursorline_transparent = false -- Set the cursorline transparent/visible
-- 		vim.g.nord_italic = false -- enables/disables italics
-- 		vim.g.nord_enable_sidebar_background = false -- Re-enables the background of the sidebar if you disabled the background of everything
-- 		vim.g.nord_uniform_diff_background = true -- enables/disables colorful backgrounds when used in diff mode
-- 		vim.g.nord_bold = false -- enables/disables bold
--
-- 		-- Load the colorscheme
-- 		require("nord").set()
--
-- 		-- Function to set menu borders to transparent
-- 		-- local set_menu_border_transparency = function()
-- 		--   vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE', fg = 'NONE' })
-- 		--   vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE', fg = 'NONE' })
-- 		-- end
--
-- 		-- Execute the function once after loading the colorscheme
-- 		-- set_menu_border_transparency()
--
-- 		local bg_transparent = true
--
-- 		-- Toggle background transparency
-- 		local toggle_transparency = function()
-- 			bg_transparent = not bg_transparent
-- 			vim.g.nord_disable_background = bg_transparent
-- 			vim.cmd([[colorscheme nord]])
-- 			-- set_menu_border_transparency()
-- 		end
--
-- 		vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true })
-- 	end,
-- } -- return {
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

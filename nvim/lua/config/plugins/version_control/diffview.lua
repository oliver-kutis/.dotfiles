return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
	keys = {
		{ "<leader>gd", ":DiffviewOpen<CR>", desc = "Diffview open" },
		{ "<leader>gq", ":DiffviewClose<CR>", desc = "Diffview close" },
		{ "<leader>gh", ":DiffviewFileHistory %<CR>", desc = "Diffview history (Current file)" },
		{ "<leader>gH", ":DiffviewFileHistory<CR>", desc = "Diffview History (Repository)" },
	},
	config = function()
		local actions = require("diffview.actions")
		local diffview = require("diffview")

		diffview.setup({
			enhanced_diff_hl = true,
			view = {
				default = {
					layout = "diff2_horizontal",
					winbar_info = true,
				},
				merge_tool = {
					layout = "diff3_mixed",
					disable_diagnostics = true,
				},
			},
			file_panel = {
				listing_style = "tree",
				win_config = { position = "left", width = 40 },
			},
			keymaps = {
				view = {
					["<leader>e"] = actions.toggle_files,
					["q"] = actions.close,
				},
				file_panel = {
					["q"] = actions.close,
				},
			},
		})

		-- Autocommands for Neo-tree integration
		vim.api.nvim_create_autocmd("User", {
			pattern = "DiffviewViewOpened",
			callback = function()
				vim.cmd("Neotree close")
			end,
		})
	end,
}

return {
	"nvim-zh/colorful-winsep.nvim",
	config = function()
		require("colorful-winsep").setup({
			border = "bold",
			-- highlight = "CursorLineNr", -- or your choice of highlight group
			highlight = "#d7a65f", -- same as tmux active pane
			excluded_ft = { "packer", "TelescopePrompt", "mason", "neo-tree" },
			excluded_bufs = { "Nvim_Tree_*", "NeoTree_*" },
			no_exec_files = { "neo-tree", "DiffviewFiles", "DiffviewFilePanel" },
			create_event = function()
				-- This helps ignore Diffview and floating windows
				local ok, win = pcall(vim.api.nvim_get_current_win)
				if not ok or not vim.api.nvim_win_is_valid(win) then
					return false
				end
				return true
			end,
		})
	end,
}

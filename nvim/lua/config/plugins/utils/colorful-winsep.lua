return {
	"nvim-zh/colorful-winsep.nvim",
	config = function()
		require("colorful-winsep").setup({
			border = "bold",
			-- highlight = "CursorLineNr", -- or your choice of highlight group
			highlight = "#d7a65f", -- same as tmux active pane
			excluded_ft = { "packer", "TelescopePrompt", "mason", "neo-tree" },
			excluded_bufs = { "Nvim_Tree_*", "NeoTree_*" },
		})
	end,
}

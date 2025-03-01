return {
	-- "folke/tokyonight.nvim",
	"EdenEast/nightfox.nvim",
	priority = 1000,
	config = function()
		-- vim.cmd("colorscheme tokyonight")
		require("nightfox").setup({
			options = {
				transparent = true,
			},
		})

		vim.cmd("colorscheme nightfox")
	end,
}

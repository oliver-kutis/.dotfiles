return {
	"nvim-zh/colorful-winsep.nvim",
	-- config = true,
	event = { "WinLeave" },
	config = function()
		require("colorful-winsep").setup({
			hi = {
				bg = "#16161E",
				fg = "#89b4fa",
			},
		})
	end,
}

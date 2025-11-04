return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	config = function()
		require("colorizer").setup({
			filetypes = {
				"!py*", -- Highlight all files, but customize some others.
				cmp_docs = { always_update = true },
			},
			names = false, -- "Name" codes like Blue or red
			buftypes = {},
		})
	end,
}

return {
	"VonHeikemen/fine-cmdline.nvim",
	dependencies = {
		{ "MunifTanjim/nui.nvim" },
	},
	config = function()
		local keymap = vim.keymap

		keymap.set("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })
	end,
}

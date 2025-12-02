return {
	"shortcuts/no-neck-pain.nvim",
	version = "*",
	opts = {
		width = 140,
	},
	vim.keymap.set("n", "<leader>cc", ":NoNeckPain<cr>", { desc = "[C]enter [C]ursor" }),
}

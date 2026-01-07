return {
	"ray-x/lsp_signature.nvim",
	event = "LspAttach",
	opts = {
		bind = true,
		floating_window = true,
		hint_enable = false, -- no inline noise
		doc_lines = 0,
		max_height = 12,
		max_width = 80,
		handler_opts = { border = "rounded" },
		zindex = 50, -- above cmp
		toggle_key = "<C-k>", -- 👈 hide / show
	},
}

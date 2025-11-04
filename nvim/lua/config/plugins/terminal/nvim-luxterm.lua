return {
	"luxvim/nvim-luxterm",
	config = function()
		require("luxterm").setup({
			-- Optional configuration
			manager_width = 0.8,
			manager_height = 0.8,
			preview_enabled = true,
			auto_hide = true,
			keymaps = {
				-- toggle_manager = "<C-/>",
				toggle_manager = "<leader>tt",
			},
		})
	end,
}

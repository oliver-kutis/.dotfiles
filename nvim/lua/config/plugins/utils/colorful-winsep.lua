return {
	"nvim-zh/colorful-winsep.nvim",
	config = function()
		local colorful_winsep = require("colorful-winsep")

		-- 1️⃣ Regular setup
		colorful_winsep.setup({
			border = "bold",
		highlight = "#8aadf4", -- Catppuccin blue (balanced blue)
			excluded_ft = { "packer", "TelescopePrompt", "mason", "neo-tree" },
			excluded_bufs = { "Nvim_Tree_*", "NeoTree_*" },
			no_exec_files = { "neo-tree", "DiffviewFiles", "DiffviewFilePanel" },
		})

		-- 2️⃣ Patch shift_move to silently ignore errors (optional, extra safety)
		local ok, sep = pcall(require, "colorful-winsep.separator")
		if ok and sep and sep.shift_move then
			local orig_shift_move = sep.shift_move
			sep.shift_move = function(...)
				local ok2, result = pcall(orig_shift_move, ...)
				if not ok2 then
					return
				end
				return result
			end
		end

		-- 3️⃣ Disable winsep automatically in Neo-tree / Diffview buffers
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = { "neo-tree", "DiffviewFiles", "DiffviewFilePanel" },
			callback = function()
				pcall(function()
					colorful_winsep.NvimSeparatorDel()
				end)
			end,
		})

		vim.api.nvim_create_autocmd("BufLeave", {
			pattern = { "neo-tree", "DiffviewFiles", "DiffviewFilePanel" },
			callback = function()
				pcall(function()
					colorful_winsep.NvimSeparatorNew()
				end)
			end,
		})
	end,
}

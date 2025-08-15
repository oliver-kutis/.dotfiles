return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async funcs
		},
		build = "make tiktoken ",
		opts = {
			model = "claude-3.7-sonnet",
			sticky = {
				-- "#files",
			},
			window = {
				layout = "vertical",
				width = 0.4,
				border = "solid",
			},
			mappings = {
				accept_diff = { normal = "<C-y>", insert = "<C-y>" },
				show_diff = { full_diff = false, normal = "<leader>gd" },
				yank_diff = { normal = "<leader>gy" },
				jump_to_diff = { normal = "<leader>gj" },
				show_context = { normal = "gc" },
				show_help = { normal = "gh" },
				show_info = { normal = "gi" },
				clear_stickies = { normal = "grx" },
				toggle_sticky = { normal = "grr" },
			},
		},
		keys = {
			{ "<leader>ct", "<cmd>CopilotChatToggle<CR>", mode = { "n", "v" }, desc = "Copilot Chat: Toggle chat" },
			{ "<leader>cp", "<cmd>CopilotChatPrompts<CR>", mode = { "n", "v" }, desc = "Copilot Chat: Show prompts" },
			{
				"<leader>cs",
				"<cmd>CopilotChatStop<CR>",
				mode = { "n", "v" },
				desc = "Copilot Chat: Stop current chat output",
			},
			{
				"<leader>cs",
				function()
					local opts = {
						prompt = "Save chat history as: ",
					}
					vim.ui.input(opts, function(filename)
						if filename and filename ~= "" then
							vim.cmd("CopilotChatSave " .. filename)
						end
					end)
				end,
				desc = "Save Copilot Chat history to file",
			},
			{
				"<leader>cr",
				function()
					local opts = {
						prompt = "Load chat history from: ",
					}
					vim.ui.input(opts, function(filename)
						if filename and filename ~= "" then
							vim.cmd("CopilotChatLoad " .. filename)
						end
					end)
				end,
				desc = "Load Copilot Chat history from file",
			},
		},

		-- lazy = true,
		-- cmd = { "CopilotChat", "CopilotChatOpen", "CopilotChatToggle" },
	},
}

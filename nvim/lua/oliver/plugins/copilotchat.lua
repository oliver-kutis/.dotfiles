return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async funcs
		},
		build = "make tiktoken ",
		opts = {
			--[[ mappings = {
        
      } ]]
		},
	},
}

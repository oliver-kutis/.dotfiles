-- lazy.nvim
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		-- Cmdline settings
		cmdline = {
			enabled = true, -- enable the new cmdline UI
			view = "cmdline_popup", -- floating popup style
			format = {
				cmdline = { icon = "> " }, -- fancy icon before your commands
			},
			opts = {
				position = {
					row = 10, -- vertical position (adjust as you like)
					col = "50%", -- horizontal center
				},
				size = {
					width = 50, -- width of the popup
				},
				border = { style = "rounded" }, -- rounded border
			},
		},

		-- Messages (like :echo, warnings, errors)
		messages = {
			enabled = true,
			view = "notify", -- show messages in notify-style popups
			view_error = "notify",
			view_warn = "notify",
			view_history = "messages", -- use :messages style for history
		},

		-- Popupmenu (completion menus)
		popupmenu = {
			enabled = true,
			backend = "nui", -- use NUI backend for completion popup
		},

		-- Presets for convenience
		presets = {
			command_palette = true, -- enable command palette style
			long_message_to_split = true, -- long messages go to a split
			inc_rename = true, -- nice UI for incremental renames
			lsp_doc_border = true, -- add border to LSP docs
		},
	},
}

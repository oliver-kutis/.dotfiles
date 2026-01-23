-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	keys = {
		-- Explorer (Filesystem)
		{ "\\", ":Neotree filesystem reveal left<CR>", desc = "Explorer", silent = true },
		-- { "<leader>ee", ":Neotree filesystem reveal left<CR>", desc = "Explorer", silent = true },
		-- {
		-- 	"<leader>ee",
		-- 	function()
		-- 		vim.cmd("Neotree filesystem reveal_file=" .. vim.fn.expand("%:p") .. " float")
		-- 	end,
		-- 	desc = "Explorer (follow current file)",
		-- 	silent = true,
		-- }, -- { "<leader>ee", ":Neotree filesystem toggle float<CR>", desc = "Explorer",   silent = true },
		{
			"<leader>ee",
			function()
				local manager = require("neo-tree.sources.manager")
				local fs = manager.get_state("filesystem")

				if fs and fs.winid and vim.api.nvim_win_is_valid(fs.winid) then
					-- Neo-tree is open → close it
					vim.cmd("Neotree close")
				else
					-- Neo-tree is closed → open and follow current file
					local file = vim.fn.expand("%:p")
					if vim.fn.filereadable(file) == 1 then
						vim.cmd("Neotree filesystem reveal_file=" .. file .. " float")
					else
						vim.cmd("Neotree filesystem float")
					end
				end
			end,
			desc = "Explorer (float, follow file)",
			silent = true,
		},
		-- Git Status (Floating)
		{ "<leader>eg", ":Neotree git_status toggle float<CR>", desc = "Git Status", silent = true },

		-- Buffers
		{ "<leader>eb", ":Neotree buffers toggle float<CR>", desc = "Buffers", silent = true },
	},
	sources = {
		"filesystem",
		"buffers",
		"git_status",
		"diagnostics",
	},
	opts = {
		close_if_last_window = false,
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,
		default_component_configs = {
			indent = {
				indent_size = 2,
				padding = 1,
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
			},
			-- icon = {
			-- 	folder_closed = '',
			-- 	folder_open = '',
			-- 	folder_empty = '󰜌',
			-- 	default = '*',
			-- 	highlight = 'NeoTreeFileIcon',
			-- },
			modified = {
				symbol = "[+]",
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false,
				-- use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					-- added = '✚',
					-- modified = '[✚]',
					deleted = "D",
					renamed = "R",
					untracked = "U",
					ignored = "I",
					unstaged = "󰄱",
					staged = "✔️",
					-- conflict = 'C',
				},
			},
		},
		window = {
			position = "left",
			width = 40,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = {
				["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
			},
		},
		filesystem = {
			filtered_items = {
				visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
				hide_gitignored = true,
				hide_dotfiles = false,
				hide_by_name = {
					".github",
				},
				never_show = { ".git", ".DS_Store", "__pycache__" },
			},
			follow_current_file = {
				enabled = true,
				leave_dirs_open = true,
			},
			group_empty_dirs = false,
			hijack_netrw_behavior = "open_default",
			use_libuv_file_watcher = true,
			window = {
				mappings = {
					["\\"] = "close_window",
					["."] = {
						"show_help",
						nowait = false,
						config = { title = "[Root] [s]et [r]eset", prefix_key = "." },
					},
					[".s"] = "set_root",
					[".r"] = "navigate_up", -- Go up to parent directory
					["e"] = "expand_all_subnodes",
					["C"] = "close_all_subnodes",
					["gd"] = {
						function(state)
							local node = state.tree:get_node()
							if node.type == "file" then
								local path = node:get_id()
								vim.cmd("DiffviewOpen " .. path)
							else
								vim.notify("Select a file to view its diff", vim.log.levels.WARN)
							end
						end,
						desc = "Open Diffview for selected file",
					},
					-- ['H'] = 'toggle_hidden',      -- Toggle hidden files
					-- ['/'] = 'fuzzy_finder',       -- Fuzzy find files
					-- ['f'] = 'filter_on_submit',   -- Filter files
					-- ['<c-x>'] = 'clear_filter',   -- Clear filter
				},
			},
		},
		buffers = {
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
			group_empty_dirs = true,
			show_unloaded = true,
			window = {
				position = "float",
				mappings = {
					-- ['bd'] = 'buffer_delete',
					-- ['<bs>'] = 'navigate_up',
					["e"] = "expand_all_subnodes",
					["C"] = "close_all_subnodes",
					["."] = {
						"show_help",
						nowait = false,
						config = { title = "[Root] [s]et [r]eset", prefix_key = "." },
					},
					[".s"] = "set_root",
					[".r"] = "navigate_up", -- Reset root back to original
					["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["oc"] = { "order_by_created", nowait = false },
					["od"] = { "order_by_diagnostics", nowait = false },
					["om"] = { "order_by_modified", nowait = false },
					["on"] = { "order_by_name", nowait = false },
					["os"] = { "order_by_size", nowait = false },
					["ot"] = { "order_by_type", nowait = false },
				},
			},
		},
		git_status = {
			window = {
				position = "float",
				mappings = {
					["e"] = "expand_all_subnodes",
					["C"] = "close_all_subnodes",
					["A"] = "git_add_all",
					["g"] = { "show_help", nowait = false, config = { title = "Git", prefix_key = "g" } },
					["gu"] = "git_unstage_file",
					["ga"] = "git_add_file",
					["gr"] = "git_revert_file",
					["gc"] = "git_commit",
					["gp"] = "git_push",
					["gg"] = "git_commit_and_push",
					["gd"] = {
						function(state)
							local node = state.tree:get_node()
							if node.type == "file" then
								local path = node:get_id()
								vim.cmd("DiffviewOpen " .. path)
							else
								vim.notify("Select a file to view its diff", vim.log.levels.WARN)
							end
						end,
						desc = "Open Diffview for selected file",
					},
					["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["oc"] = { "order_by_created", nowait = false },
					["od"] = { "order_by_diagnostics", nowait = false },
					["om"] = { "order_by_modified", nowait = false },
					["on"] = { "order_by_name", nowait = false },
					["os"] = { "order_by_size", nowait = false },
					["ot"] = { "order_by_type", nowait = false },
				},
			},
		},
	},
}

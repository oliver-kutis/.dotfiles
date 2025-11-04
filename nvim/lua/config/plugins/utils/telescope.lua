return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		local actions = require("telescope.actions")
		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local conf = require("telescope.config").values
		local action_state = require("telescope.actions.state")

		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { "%.git/" },
				mappings = {
					i = {
						["<C-h>"] = actions.select_horizontal,
						["<C-s>"] = actions.select_vertical,
						["<c-enter>"] = "to_fuzzy_refine",
					},
					n = {
						["<C-h>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
				},
				buffers = {
					sort_lastused = true,
					ignore_current_buffer = true,
				},
				oldfiles = {
					sort_lastused = true,
					ignore_current_buffer = true,
				},
			},
			extensions = {
				["ui-select"] = require("telescope.themes").get_dropdown(),
			},
			popup_mappings = {
				scroll_down = "<C-d>",
				scroll_up = "<C-u>",
			},
		})

		-- Enable Telescope extensions if installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "todo-comments")

		-- Custom picker: Open terminal buffers only
		-- local function open_terminal_buffers()
		-- 	local term_bufs = {}
		--
		-- 	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		-- 		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == 'terminal' then
		-- 			-- Extract job name or fallback to buffer name
		-- 			local name = vim.api.nvim_buf_get_name(buf)
		-- 			if name == '' then
		-- 				name = '[No Name]'
		-- 			end
		-- 			table.insert(term_bufs, { buf = buf, name = name })
		-- 		end
		-- 	end
		--
		-- 	if #term_bufs == 0 then
		-- 		vim.notify('No terminal buffers open', vim.log.levels.INFO)
		-- 		return
		-- 	end
		--
		-- 	pickers
		-- 	    .new({}, {
		-- 		    prompt_title = 'Open Terminal Buffers',
		-- 		    finder = finders.new_table {
		-- 			    results = term_bufs,
		-- 			    entry_maker = function(entry)
		-- 				    return {
		-- 					    value = entry.buf,
		-- 					    display = entry.name,
		-- 					    ordinal = entry.name,
		-- 				    }
		-- 			    end,
		-- 		    },
		-- 		    sorter = conf.generic_sorter {},
		-- 		    attach_mappings = function(_, map)
		-- 			    map('i', '<CR>', function(prompt_bufnr)
		-- 				    local selection = action_state.get_selected_entry()
		-- 				    actions.close(prompt_bufnr)
		-- 				    vim.api.nvim_set_current_buf(selection.value)
		-- 			    end)
		-- 			    map('n', '<CR>', function(prompt_bufnr)
		-- 				    local selection = action_state.get_selected_entry()
		-- 				    actions.close(prompt_bufnr)
		-- 				    vim.api.nvim_set_current_buf(selection.value)
		-- 			    end)
		-- 			    return true
		-- 		    end,
		-- 	    })
		-- 	    :find()
		-- end

		-- Create user command
		-- vim.api.nvim_create_user_command('Terminals', open_terminal_buffers, {})

		-- Keybinding for terminal picker
		-- vim.keymap.set('n', '<leader>st', open_terminal_buffers, { desc = '[S]earch [T]erminal Buffers' })

		-- TODO comments pull up
		vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "[S]earch [T]odo Comments" })

		-- Built-in Telescope pickers
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", function()
			builtin.diagnostics({ bufnr = 0 })
		end, { desc = "[S]earch [D]iagnostics (current buffer)" })
		vim.keymap.set("n", "<leader>sD", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.buffers, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, { desc = "[ ] Find existing buffers" })

		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim config files" })
	end,
}

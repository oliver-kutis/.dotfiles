-- Adds git related signs to the gutter, as well as utilities for managing changes
-- NOTE: gitsigns is already included in init.lua but contains only the base
-- config. This will add also the recommended keymaps.

return {
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '┃' },
				change = { text = '┃' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
				untracked = { text = '┆' },
			},
			signs_staged = {
				add = { text = '┃' },
				change = { text = '┃' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
				untracked = { text = '┆' },
			},
			signs_staged_enable = true,
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
			},
			current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = 'rounded',
				style = 'minimal',
				relative = 'cursor',
				row = 1,
				col = 0,
				width = 80,
				height = 20,
				focusable = true,
				zindex = 100,
			},
			on_attach = function(bufnr)
				local gitsigns = require 'gitsigns'

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map('n', ']c', function()
					if vim.wo.diff then
						vim.cmd.normal { ']c', bang = true }
					else
						gitsigns.nav_hunk 'next'
					end
				end, { desc = 'Jump to next git [c]hange' })

				map('n', '[c', function()
					if vim.wo.diff then
						vim.cmd.normal { '[c', bang = true }
					else
						gitsigns.nav_hunk 'prev'
					end
				end, { desc = 'Jump to previous git [c]hange' })

				-- Actions
				-- visual mode
				map('v', '<leader>hs', function()
					gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
				end, { desc = 'git [s]tage hunk' })
				map('v', '<leader>hr', function()
					gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
				end, { desc = 'git [r]eset hunk' })
				-- normal mode
				map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
				map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
				map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
				map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
				map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
				map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
				map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
				map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
				map('n', '<leader>hD', function()
					gitsigns.diffthis '@'
				end, { desc = 'git [D]iff against last commit' })
				-- Toggles
				map('n', '<leader>tb', gitsigns.toggle_current_line_blame,
					{ desc = '[T]oggle git show [b]lame line' })
				map('n', '<leader>tD', gitsigns.preview_hunk_inline,
					{ desc = '[T]oggle git show [D]eleted' })

				-- Enhanced preview with focus
				map('n', '<leader>hP', function()
					-- Use diffthis for a proper scrollable diff view
					gitsigns.diffthis()
				end, { desc = 'git [P]review hunk (scrollable diff)' })

				-- Better preview: Show hunk in a new buffer (more readable)
				map('n', '<leader>hv', function()
					-- Create a new buffer with the hunk content
					local hunks = gitsigns.get_hunks()
					if not hunks or #hunks == 0 then
						print 'No hunks found'
						return
					end

					-- Find the hunk at current cursor position
					local current_line = vim.fn.line '.'
					local current_hunk = nil
					for _, hunk in ipairs(hunks) do
						if current_line >= hunk.added.start and current_line <= (hunk.added.start + hunk.added.count - 1) then
							current_hunk = hunk
							break
						elseif current_line >= hunk.removed.start and current_line <= (hunk.removed.start + hunk.removed.count - 1) then
							current_hunk = hunk
							break
						end
					end

					if current_hunk then
						-- Open a new buffer with better formatting
						vim.cmd 'new'
						vim.bo.buftype = 'nofile'
						vim.bo.bufhidden = 'wipe'
						vim.bo.swapfile = false
						vim.bo.filetype = 'diff'

						-- Set content
						local lines = vim.split(
						gitsigns.get_hunks(current_line)[1] or 'No hunk content', '\n')
						vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
						vim.bo.modifiable = false

						-- Add keymaps for this buffer
						vim.keymap.set('n', 'q', '<cmd>close<cr>',
							{ buffer = true, silent = true })
						vim.keymap.set('n', '<Esc>', '<cmd>close<cr>',
							{ buffer = true, silent = true })
					else
						gitsigns.preview_hunk()
					end
				end, { desc = 'git [v]iew hunk (new buffer)' })

				-- Alternative: Use telescope for scrollable preview
				map('n', '<leader>hT', function()
					if pcall(require, 'telescope.builtin') then
						require('telescope.builtin').git_bcommits()
					else
						-- Fallback to regular preview
						gitsigns.preview_hunk()
					end
				end, { desc = 'git [T]elescope commits for current buffer' })
			end,
		},
	},
}

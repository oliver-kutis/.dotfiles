return {
	'nvim-treesitter/nvim-treesitter-context',
	config = function()
		require('treesitter-context').setup {
			enable = true, -- Enable this plugin
			-- max_lines = 3, -- Max number of lines to show
			min_window_height = 0, -- Minimum editor height to enable
			line_numbers = true, -- Show line numbers in context
			multiline_threshold = 20, -- Max lines for a single context block
			trim_scope = 'inner', -- Trim inner / outer scopes
			mode = 'cursor', -- Show scope under cursor
			separator = '-', -- Optional separator line
			-- multiwindow = true,
		}
	end,
}

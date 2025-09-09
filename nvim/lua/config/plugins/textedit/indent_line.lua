return {
	{ -- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = 'ibl',
		opts = {
			indent = { char = '┆' },
			scope = { enabled = true, char = '┆' },
			-- indent = { char = "", highlight = { "CursorColumn", "Whitespace" } },
		},
	},
}

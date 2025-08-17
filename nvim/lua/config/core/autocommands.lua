-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Enhanced floating window styling for gitsigns and other popups
vim.api.nvim_create_autocmd('FileType', {
	desc = 'Enhanced styling for gitsigns preview and diff windows',
	group = vim.api.nvim_create_augroup('gitsigns-styling', { clear = true }),
	pattern = { 'gitsigns.blame', 'gitsigns.diff', 'diff' },
	callback = function()
		-- Add padding and better styling
		vim.opt_local.winblend = 10 -- Slight transparency
		vim.opt_local.wrap = false -- No line wrapping
		vim.opt_local.cursorline = true -- Highlight current line
	end,
})

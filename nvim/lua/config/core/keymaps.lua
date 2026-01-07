-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

-- Stay in Visual / Visual-Line mode after indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and stay in visual mode' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and stay in visual mode' })

-- Move Up / Down half-page
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move half the page UP and center cursor on the screen' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move half the page DOWN and center cursor on the screen' })

-- Move selected lines up and down
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selected lines below' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selected lines above' })

-- Move current line up and down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })

-- Duplicate selected lines up and down
vim.keymap.set('v', '<A-S-j>', "y'<P", { noremap = true, silent = true })
vim.keymap.set('v', '<A-S-k>', "y'<P", { noremap = true, silent = true })

-- Duplicate current line up and down
vim.keymap.set('n', '<A-S-j>', ':t.<CR>', { noremap = true, silent = true, desc = 'Duplicate line below' })
vim.keymap.set('n', '<A-S-k>', ':t-1<CR>', { noremap = true, silent = true, desc = 'Duplicate line above' })

-- Go to normal mode by typing "jk"
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode with jk' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Enhanced diagnostic navigation and display
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show line diagnostics in floating window' })
vim.keymap.set('n', '<leader>E', function()
	vim.diagnostic.open_float({ scope = 'buffer' })
end, { desc = 'Show all buffer diagnostics in floating window' })

-- Toggle virtual text on/off
vim.keymap.set('n', '<leader>td', function()
	local bufnr = vim.api.nvim_get_current_buf()
	local winid = vim.b[bufnr].__diagnostic_float_winid
	if winid and vim.api.nvim_win_is_valid(winid) then
		pcall(vim.api.nvim_win_close, winid, true)
		vim.b[bufnr].__diagnostic_float_winid = nil
		return
	end

	local line = vim.api.nvim_win_get_cursor(0)[1] - 1
	local diagnostics = vim.diagnostic.get(bufnr, { lnum = line })
	if #diagnostics == 0 then
		return
	end

	winid = vim.diagnostic.open_float(nil, {
		focus = false,
		scope = 'line',
		pos = { line, 0 },
		border = 'rounded',
		source = 'if_many',
		close_events = { 'CursorMoved', 'InsertEnter', 'BufHidden', 'FocusLost' },
	})
	vim.b[bufnr].__diagnostic_float_winid = winid
end, { desc = 'Toggle diagnostic float (current line)' })

-- Show full diagnostic message in echo area (good for very long messages)
vim.keymap.set('n', '<leader>de', function()
	local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
	if #diagnostics > 0 then
		vim.api.nvim_echo({{diagnostics[1].message, 'Normal'}}, false, {})
	end
end, { desc = 'Echo full diagnostic message' })

-- Show only closest diagnostic to cursor
vim.keymap.set('n', '<leader>dc', function()
	local bufnr = vim.api.nvim_get_current_buf()
	local line = vim.api.nvim_win_get_cursor(0)[1] - 1
	local col = vim.api.nvim_win_get_cursor(0)[2]
	
	local diagnostics = vim.diagnostic.get(bufnr, { lnum = line })
	if #diagnostics == 0 then
		print("No diagnostics on current line")
		return
	end
	
	-- Find closest diagnostic by column distance
	local closest = diagnostics[1]
	local min_distance = math.abs(col - closest.col)
	
	for _, diag in ipairs(diagnostics) do
		local distance = math.abs(col - diag.col)
		if distance < min_distance then
			closest = diag
			min_distance = distance
		end
	end
	
	-- Show the closest diagnostic in a float
	vim.diagnostic.open_float({
		bufnr = bufnr,
		pos = { closest.lnum, closest.col },
		severity = closest.severity,
	})
end, { desc = 'Show closest diagnostic to cursor' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = 'Open new tab' }) -- open new tab
vim.keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close current tab' }) -- close current tab
vim.keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Go to next tab' }) --  go to next tab
vim.keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = 'Go to previous tab' }) --  go to previous tab
vim.keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = 'Open current buffer in new tab' }) --  move current buffer to new tab

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

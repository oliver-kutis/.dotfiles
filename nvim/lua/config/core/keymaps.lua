-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Stay in Visual / Visual-Line mode after indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and stay in visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and stay in visual mode" })

-- Normal mode: C-m → Visual Block mode
vim.api.nvim_set_keymap("n", "<C-m>", "<C-v>", { noremap = true, silent = true })

-- Visual mode mapping: multi-edit all occurrences of selected text
vim.keymap.set("v", "<leader>*", [[:<C-u>let @/ = '\V'.escape(@", '\')<CR>cgn]], { noremap = true, silent = true })

-- Move Up / Down half-page
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move half the page UP and center cursor on the screen" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move half the page DOWN and center cursor on the screen" })

-- Move selected lines up and down
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selected lines below" })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selected lines above" })

-- Move current line up and down
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { noremap = true, silent = true })

-- Duplicate selected lines up and down
vim.keymap.set("v", "<M-S-j>", "y'<P", { noremap = true, silent = true })
vim.keymap.set("v", "<M-S-k>", "y'<P", { noremap = true, silent = true })

-- Duplicate current line up and down
vim.keymap.set("n", "<M-S-j>", ":t.<CR>", { noremap = true, silent = true, desc = "Duplicate line below" })
vim.keymap.set("n", "<M-S-k>", ":t-1<CR>", { noremap = true, silent = true, desc = "Duplicate line above" })

-- Go to normal mode by typing "jk"
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Window management
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "[V]ertical split" })
vim.keymap.set("n", "<leader>wh", "<cmd>split<cr>", { desc = "[H]orizontal split" })
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "[E]qualize splits" })
vim.keymap.set("n", "<leader>wc", "<cmd>close<cr>", { desc = "[C]lose split" })
vim.keymap.set("n", "<leader>wV", "<cmd>vnew<cr>", { desc = "[V]split New empty window" })
vim.keymap.set("n", "<leader>wH", "<cmd>new<cr>", { desc = "[H]split New empty window" })
vim.keymap.set("n", "<leader>wh", "<C-w>h<C-w>x", { desc = "Move window left" })
vim.keymap.set("n", "<leader>wl", "<C-w>l<C-w>x", { desc = "Move window right" })
vim.keymap.set("n", "<leader>wk", "<C-w>k<C-w>x", { desc = "Move window up" })
vim.keymap.set("n", "<leader>wj", "<C-w>j<C-w>x", { desc = "Move window down" })

-- Enhanced diagnostic navigation and display
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

-- Toggle virtual text on/off
vim.keymap.set("n", "<leader>td", function()
	local config = vim.diagnostic.config()
	vim.diagnostic.config({
		virtual_text = not config.virtual_text,
	})
end, { desc = "Toggle diagnostic virtual text" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Navigation in terminal mode (insert-like)
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { silent = true })
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { silent = true })
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { silent = true })
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { silent = true })

-- Tabs
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

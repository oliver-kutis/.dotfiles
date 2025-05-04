vim.g.mapleader = " "

-- open config
vim.cmd('nmap <leader>c :e ~/.config/nvim/vscode/init.lua<cr>')

-- save
vim.cmd('nmap <leader>s :w<cr>')

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
if vim.g.vscode then
    print("Running in VSCode")
end
-- local code = require("vscode")
-- keymap.set(
--     "n",
--     "<leader>e",
--     function()
--         code.action("workbech.action.showAllEditors")
--     end,
--     {  noremap = true, silent = true }
-- )

keymap.set("n", "<C-h>", "<cmd> lua require('vscode').action('workbench.action.navigateLeft')<CR>", { desc = "Navigate left"})
keymap.set({"n", "v"}, "<leader>k", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights"})
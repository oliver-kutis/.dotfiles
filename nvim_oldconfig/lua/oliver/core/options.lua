vim.cmd("let g:netrw_liststyle = 3")
vim.cmd("let g:python3_host_prog = '/Users/kutis/.pyenv/versions/py3nvim/bin/python'")

local opt = vim.opt

opt.relativenumber = true -- makes nubmer of lines relative to current lines (e.g. to move 6 lines above: press 4 + k, this will bring us to the first line in the editor if we're on current line)
opt.number = true -- makes the number of current line more stand out

-- tabs & intendation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy ident from current line when starting new one

opt.wrap = false -- don't wrap the lines

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in search, assumes you want case-sensitive search

opt.cursorline = true -- highlights the current cursor line

-- Color scheme settings
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

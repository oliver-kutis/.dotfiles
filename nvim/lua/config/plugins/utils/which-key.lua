return {
	'folke/which-key.nvim',
	event = 'VimEnter', -- Load on VimEnter
	config = function()
		local wk = require 'which-key'

		-- === Which-key general settings ===
		wk.setup {
			delay = 0, -- no delay for popup
			icons = {
				mappings = vim.g.have_nerd_font,
				keys = vim.g.have_nerd_font and {} or {
					Up = '<Up> ',
					Down = '<Down> ',
					Left = '<Left> ',
					Right = '<Right> ',
					C = '<C-…> ',
					M = '<M-…> ',
					D = '<D-…> ',
					S = '<S-…> ',
					CR = '<CR> ',
					Esc = '<Esc> ',
					ScrollWheelDown = '<ScrollWheelDown> ',
					ScrollWheelUp = '<ScrollWheelUp> ',
					NL = '<NL> ',
					BS = '<BS> ',
					Space = '<Space> ',
					Tab = '<Tab> ',
					F1 = '<F1>',
					F2 = '<F2>',
					F3 = '<F3>',
					F4 = '<F4>',
					F5 = '<F5>',
					F6 = '<F6>',
					F7 = '<F7>',
					F8 = '<F8>',
					F9 = '<F9>',
					F10 = '<F10>',
					F11 = '<F11>',
					F12 = '<F12>',
				},
			},
		}

		-- === Register <leader> keymap groups ===
		wk.add {
			{ '<leader>s', group = '[S]earch' },
			{ '<leader>t', group = '[T]oggle' },
			{ '<leader>h', group = 'Git [H]unk',                mode = { 'n', 'v' } },
			{ '<leader>e', group = 'Neotree [E]xplorer' },
			{ '<leader>b', group = 'Split [B]uffer Management ' },
		}

		-- -- === Dynamically register Control keymaps ===
		-- local ctrl_maps = {}
		-- for _, map in ipairs(vim.api.nvim_get_keymap("n")) do
		-- 	if map.lhs:match("^<C%-.") then
		-- 		local key = map.lhs:match("^<C%-(.)")
		-- 		ctrl_maps[key] = { map.rhs or "", map.desc or ("Ctrl+" .. key) }
		-- 	end
		-- end
		--
		-- wk.add({
		-- 	["<C-Space>"] = {
		-- 		name = "+Control Maps",
		-- 		unpack(ctrl_maps),
		-- 	},
		-- })
	end,
}

return {
	-- Completion engine
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Completion sources
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",

			-- Snippets
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			"saadparwaiz1/cmp_luasnip",

			-- GitHub Copilot
			{
				"zbirenbaum/copilot.lua",
				cmd = "Copilot",
				build = ":Copilot auth",
				opts = {
					suggestion = { enabled = false }, -- disable ghost text
					panel = { enabled = false },
					filetypes = {
						lua = true,
						python = true, -- enable Copilot for Python
						javascript = true, -- optional example
						typescript = true,
						-- ["*"] = false,    -- optional: disable for all other filetypes
					},
				},
			},
			-- {
			-- 	"zbirenbaum/copilot-cmp",
			-- 	dependencies = { "zbirenbaum/copilot.lua" },
			-- 	config = function()
			-- 		require("copilot_cmp").setup()
			-- 	end,
			-- },
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				view = {
					docs = {
						auto_open = true,
					},
				},
				completion = {
					autocomplete = {
						cmp.TriggerEvent.InsertEnter,
						cmp.TriggerEvent.TextChanged,
					},
				},
				window = {
					documentation = cmp.config.window.bordered({
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
					}),
					completion = cmp.config.window.bordered({
						max_height = 10,
						scrollbar = true,
						border = "rounded",
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
					}),
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					-- ["<Tab>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.select_next_item()
					-- 	elseif luasnip.expand_or_jumpable() then
					-- 		luasnip.expand_or_jump()
					-- 	else
					-- 		fallback()
					-- 	end
					-- end, { "i", "s" }),
					-- ["<S-Tab>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.select_prev_item()
					-- 	elseif luasnip.jumpable(-1) then
					-- 		luasnip.jump(-1)
					-- 	else
					-- 		fallback()
					-- 	end
					-- end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "copilot", group_index = 2 },
					{ name = "nvim_lsp", max_item_count = 10 },
					{ name = "luasnip", max_item_count = 10 },
					{ name = "buffer", max_item_count = 10 },
					{ name = "path", max_item_count = 10 },
				}),
				formatting = {
					format = function(entry, vim_item)
						if entry.source.name == "copilot" then
							vim_item.kind = " Copilot"
							vim_item.kind_hl_group = "CmpItemKindCopilot"
						end
						return vim_item
					end,
				},
			})
		end,
	},
}

return {
	"savq/melange-nvim",
	config = function()
		vim.cmd.colorscheme("melange")
		-- =========================
		-- Base highlights
		-- =========================
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#2a2a25" }) -- dark sand tone
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#d7a65f", bg = "#2a2a25" }) -- spice/orange accent

		-- Comments / syntax
		-- vim.api.nvim_set_hl(0, "Comment", { fg = "#a89f7e", italic = true })
		vim.api.nvim_set_hl(0, "Comment", { fg = "#8a806b", italic = true })
		vim.api.nvim_set_hl(0, "Keyword", { fg = "#d7a65f", bold = true })
		vim.api.nvim_set_hl(0, "Function", { fg = "#e3b97d", bold = true, italic = true })
		vim.api.nvim_set_hl(0, "Conditional", { fg = "#e3b97d", italic = true })

		-- Line numbers
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#6f6758" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#d7a65f", bold = true })

		-- =========================
		-- Gitsigns highlights
		-- =========================
		vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#9acb68" })
		vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#d7a65f" })
		vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#d75f5f" })

		-- Diff colors
		vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#3b4420", fg = "#d7d0c7", bold = true })
		vim.api.nvim_set_hl(0, "DiffChange", { bg = "#4a3e23", fg = "#d7d0c7", bold = true })
		vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#442020", fg = "#d7d0c7", bold = true })
		vim.api.nvim_set_hl(0, "DiffText", { bg = "#5a3f1c", fg = "#d7d0c7", bold = true })

		-- =========================
		-- Neo-tree integration
		-- =========================
		-- Transparent Neo-tree
		vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none", fg = "#e3d8b0" })
		vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none", fg = "#cfc5a3" })
		vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#2f2b20" }) -- optional subtle shading
		vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { fg = "none", bg = "none" })
		-- vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#2a2a25", fg = "#e3d8b0" })
		-- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#2a2a25", fg = "#cfc5a3" })
		-- vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#2f2b20" })
		-- vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { fg = "#d7a65f", bg = "#2a2a25" })
		vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#e3b97d", bold = true })
		vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#cfc5a3" })
		vim.api.nvim_set_hl(0, "NeoTreeDimText", { fg = "#a89f7e" })
		vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#9acb68" })
		vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#d7a65f" })
		vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#d75f5f" })

		-- =========================
		-- Floating and popup menus
		-- =========================
		vim.api.nvim_set_hl(0, "Pmenu", { bg = "#2b271e", fg = "#d7c89f" })
		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#d7a65f", fg = "#1c1b18" })
		vim.api.nvim_set_hl(0, "Visual", { bg = "#3f3622" })
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2f2b20" })
	end,
}

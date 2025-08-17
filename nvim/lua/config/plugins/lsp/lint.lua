return {

	{ -- Linting
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				-- python = { "ruff" },
			}

			-- To allow other plugins to add linters to require('lint').linters_by_ft,
			-- instead set linters_by_ft like this:
			-- lint.linters_by_ft = lint.linters_by_ft or {}
			-- lint.linters_by_ft['markdown'] = { 'markdownlint' }
			--
			-- However, note that this will enable a set of default linters,
			-- which will cause errors unless these tools are available:
			-- {
			--   clojure = { "clj-kondo" },
			--   dockerfile = { "hadolint" },
			--   inko = { "inko" },
			--   janet = { "janet" },
			--   json = { "jsonlint" },
			--   markdown = { "vale" },
			--   rst = { "vale" },
			--   ruby = { "ruby" },
			--   terraform = { "tflint" },
			--   text = { "vale" }
			-- }
			--
			-- Disable default linters explicitly
			lint.linters_by_ft.clojure = nil
			lint.linters_by_ft.dockerfile = nil
			lint.linters_by_ft.inko = nil
			lint.linters_by_ft.janet = nil
			lint.linters_by_ft.json = nil
			lint.linters_by_ft.rst = nil
			lint.linters_by_ft.ruby = nil
			lint.linters_by_ft.terraform = nil
			lint.linters_by_ft.text = nil

			-- Create autocommand which carries out the actual linting
			-- on the specified events.
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					-- Only run the linter in buffers that you can modify in order to
					-- avoid superfluous noise, notably within the handy LSP pop-ups that
					-- describe the hovered symbol using Markdown.
					if vim.bo.modifiable then
						lint.try_lint()
					end
				end,
			})

			-- Set up diagnostic priority after LSP attach
			-- vim.api.nvim_create_autocmd("LspAttach", {
			-- 	group = vim.api.nvim_create_augroup("lsp-diagnostic-priority", { clear = true }),
			-- 	callback = function(event)
			-- 		-- Configure diagnostic handlers to prioritize pyright
			-- 		local original_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
			-- 		vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
			-- 			-- Call original handler first
			-- 			original_handler(err, result, ctx, config)
			--
			-- 			-- Get all diagnostics for this buffer
			-- 			local diagnostics = vim.diagnostic.get(event.buf)
			--
			-- 			-- Group diagnostics by line and column
			-- 			local grouped = {}
			-- 			for _, diag in ipairs(diagnostics) do
			-- 				local key = diag.lnum .. ":" .. diag.col
			-- 				if not grouped[key] then
			-- 					grouped[key] = {}
			-- 				end
			-- 				table.insert(grouped[key], diag)
			-- 			end
			--
			-- 			-- For each position, prioritize pyright diagnostics
			-- 			local filtered = {}
			-- 			for _, group in pairs(grouped) do
			-- 				local pyright_diags = {}
			-- 				local other_diags = {}
			--
			-- 				for _, diag in ipairs(group) do
			-- 					if diag.source == "Pyright" then
			-- 						table.insert(pyright_diags, diag)
			-- 					else
			-- 						table.insert(other_diags, diag)
			-- 					end
			-- 				end
			--
			-- 				-- If pyright has diagnostics for this position, prefer them
			-- 				if #pyright_diags > 0 then
			-- 					for _, diag in ipairs(pyright_diags) do
			-- 						table.insert(filtered, diag)
			-- 					end
			-- 				else
			-- 					for _, diag in ipairs(other_diags) do
			-- 						table.insert(filtered, diag)
			-- 					end
			-- 				end
			-- 			end
			--
			-- 			-- Set the filtered diagnostics
			-- 			vim.diagnostic.set(vim.lsp.diagnostic.get_namespace(ctx.client_id), event.buf, filtered)
			-- 		end
			-- 	end,
			-- })
		end,
	},
}

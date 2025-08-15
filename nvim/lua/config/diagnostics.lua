-- [[ Configure diagnostic display ]]

vim.diagnostic.config({
  virtual_text = {
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      -- Show source for better identification
      local source = diagnostic.source and ("[" .. diagnostic.source .. "] ") or ""
      return source .. diagnostic.message
    end,
  },
  severity_sort = true,
  float = { 
    border = "rounded", 
    source = "if_many" 
  },
  underline = { 
    severity = vim.diagnostic.severity.ERROR 
  },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  } or {},
})

-- Set up diagnostic priority after LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-diagnostic-priority", { clear = true }),
  callback = function(event)
    -- Configure diagnostic handlers to prioritize pyright
    local original_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
      -- Call original handler first
      original_handler(err, result, ctx, config)
      
      -- Get all diagnostics for this buffer
      local diagnostics = vim.diagnostic.get(event.buf)
      
      -- Group diagnostics by line and column
      local grouped = {}
      for _, diag in ipairs(diagnostics) do
        local key = diag.lnum .. ":" .. diag.col
        if not grouped[key] then
          grouped[key] = {}
        end
        table.insert(grouped[key], diag)
      end
      
      -- For each position, prioritize pyright diagnostics
      local filtered = {}
      for _, group in pairs(grouped) do
        local pyright_diags = {}
        local other_diags = {}
        
        for _, diag in ipairs(group) do
          if diag.source == "Pyright" then
            table.insert(pyright_diags, diag)
          else
            table.insert(other_diags, diag)
          end
        end
        
        -- If pyright has diagnostics for this position, prefer them
        if #pyright_diags > 0 then
          for _, diag in ipairs(pyright_diags) do
            table.insert(filtered, diag)
          end
        else
          for _, diag in ipairs(other_diags) do
            table.insert(filtered, diag)
          end
        end
      end
      
      -- Set the filtered diagnostics
      vim.diagnostic.set(vim.lsp.diagnostic.get_namespace(ctx.client_id), event.buf, filtered)
    end
  end,
})

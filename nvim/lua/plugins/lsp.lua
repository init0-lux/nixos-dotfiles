local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Go
vim.lsp.config("gopls", {
  capabilities = capabilities,
})
vim.lsp.enable("gopls")

-- Rust
vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
})
vim.lsp.enable("rust_analyzer")

-- TypeScript
vim.lsp.config("ts_ls", {
  capabilities = capabilities,
})
vim.lsp.enable("ts_ls")

-- Nix
vim.lsp.config("nil_ls", {
  capabilities = capabilities,
})
vim.lsp.enable("nil_ls")

-- Dart
vim.lsp.config("dartls", {
  capabilities = capabilities,
})
vim.lsp.enable("dartls")

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
  end,
})

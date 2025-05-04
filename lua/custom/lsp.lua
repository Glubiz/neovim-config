-- lua/custom/lsp.lua

-- 1. Bootstrap Mason and Mason-LSPConfig with ensure_installed
local mason        = require("mason")
local mason_lsp    = require("mason-lspconfig")
local lspconfig    = require("lspconfig")

mason.setup({
  -- you can tweak the UI here if you like
  ui = {
    border = "rounded",
  },
  -- **Install servers & tools automatically**
  ensure_installed = {
    -- LSP servers
    "rust_analyzer",
    "tsserver",
    "html",
    "cssls",
    "jsonls",
    "yamlls",
    "taplo",         -- TOML

    -- Formatters & Linters (via Mason’s registry)
    "prettier",      -- JS/TS/HTML/CSS/JSON/YAML
    "eslint_d",      -- fast ESLint
    "stylua",        -- Lua formatter (for your Neovim config!)
    -- you can add more, e.g. "shfmt", "black", "flake8", etc.
  },
})

-- Have mason-lspconfig automatically install and setup handlers
mason_lsp.setup({
  ensure_installed = mason.settings.ensure_installed,
  automatic_installation = true,
})

-- 2. Common on_attach for all servers
local on_attach = function(client, bufnr)
  -- Example keymaps
  local bufmap = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end

  bufmap("n", "gd", vim.lsp.buf.definition)
  bufmap("n", "gr", vim.lsp.buf.references)
  bufmap("n", "K",  vim.lsp.buf.hover)
  bufmap("n", "<Leader>rn", vim.lsp.buf.rename)
  bufmap("n", "<Leader>ca", vim.lsp.buf.code_action)
end

-- 3. Loop through each server and apply the same on_attach + flags
local servers = {
  "rust_analyzer",
  "tsserver",
  "html",
  "cssls",
  "jsonls",
  "yamlls",
  "taplo",
}

for _, srv in ipairs(servers) do
  lspconfig[srv].setup({
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
  })
end

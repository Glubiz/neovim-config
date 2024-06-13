local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local lsps = require "mason.lsps"

local excluded_lsps =  {
  "gitlab-ci-ls",
  "rust-analyzer",
  "yaml-language-server",
}

local function does_not_include_value (tab, val)
  for index, value in ipairs(tab) do
      if value == val then
          return false
      end
  end

  return true
end

local function map_lsp (val)
  if val == 'css-lsp' then
    return 'cssls'
  elseif val == 'dockerfile-language-server' then
    return 'dockerls'
  elseif val == 'html-lsp' then
    return 'html'
  elseif val == 'json-lsp' then
    return 'jsonls'
  elseif val == 'yaml-language-server' then
    return 'yamlls'
  else 
    return val
  end
end

for _, lsp in ipairs(lsps) do
  if does_not_include_value(excluded_lsps, lsp) then
    lspconfig[map_lsp(lsp)].setup {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
    }
  end 
end

-- GROUP: [[ UI ]]
local border = "rounded" -- "single" | "rounded"
-- local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

-- :LspInfo
local win = require "lspconfig.ui.windows"
win.default_options = { border = border }

-- vim.diagnostic.open_float()
vim.diagnostic.config { virtual_text = true, float = { border = border } }

-- vim.lsp.buf.hover()
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })

-- vim.lsp.buf.signature_help()
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
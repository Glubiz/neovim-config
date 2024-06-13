local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

vim.g.rustaceanvim = {
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                inlayHints = {
                    bindingModeHints = {
                        enable = false,
                    },
                    chainingHints = {
                        enable = true,
                    },
                    closingBraceHints = {
                        enable = true,
                        minLines = 25,
                    },
                    closureReturnTypeHints = {
                        enable = "never",
                    },
                    lifetimeElisionHints = {
                        enable = "never",
                        useParameterNames = false,
                    },
                    maxLength = 25,
                    parameterHints = {
                        enable = true,
                    },
                    reborrowHints = {
                        enable = "never",
                    },
                    renderColons = true,
                    typeHints = {
                        enable = true,
                        hideClosureInitialization = false,
                        hideNamedConstructor = false,
                    },
                },
            },
        },
    },
}
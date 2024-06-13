-- https://github.com/stevearc/conform.nvim
return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
}
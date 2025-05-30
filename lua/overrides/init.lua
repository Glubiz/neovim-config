return {
    -- https://github.com/neovim/nvim-lspconfig
    {
      "neovim/nvim-lspconfig",
      dependencies = "folke/neodev.nvim",
      config = function()
        require("nvchad.configs.lspconfig").defaults()
        require "configs.lspconfig"
      end,
      opts = {
        inlay_hints = { enabled = true },
      },
    },
    -- https://github.com/hrsh7th/nvim-cmp
    {
      "hrsh7th/nvim-cmp",
      opts = require "configs.cmp",
    },
    -- https://github.com/nvim-telescope/telescope.nvim
    {
      "nvim-telescope/telescope.nvim",
      opts = require "configs.telescope",
    },
    -- https://github.com/stevearc/conform.nvim
    {
      "stevearc/conform.nvim",
      event = "BufWritePre",
      opts = require "configs.conform",
    },
    -- https://github.com/williamboman/mason.nvim
    {
      "williamboman/mason.nvim",
      opts = require "configs.mason",
    },
    -- https://github.com/nvim-treesitter/nvim-treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "nvim-treesitter/playground" },
      opts = require "configs.treesitter",
    },
    -- https://github.com/nvim-tree/nvim-tree.lua
    {
      "nvim-tree/nvim-tree.lua",
      opts = require "configs.nvimtree",
    },
  }
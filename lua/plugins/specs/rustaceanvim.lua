return {
  "mrcjkb/rustaceanvim",
  version = "^3",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
    {
      "lvimuser/lsp-inlayhints.nvim",
      opts = {} -- Ensure this table is correctly set up
    },
  },
  ft = { "rust" },
  config = function()
    require "configs.rustaceanvim"
  end
}

return {
  -- [COSMETICS] -- 


  -- [LSP's] -- 
  { import = "plugins.lsp.lspconfig" },
  { import = "plugins.lsp.lspsaga" },
  { import = "plugins.lsp.rustaceanvim" },

  -- [MANAGERS] -- 
  { import = "plugins.manager.mason" },
  { import = "plugins.manager.treesitter" },

  -- [MISC] -- 
  { import = "plugins.misc.cmp" },
  { import = "plugins.misc.comform" },
  { import = "plugins.misc.copilot" },
  { import = "plugins.misc.crates" },
  { import = "plugins.misc.trouble" },

  -- [NAVIGATION] -- 
  { import = "plugins.navigation.nvim-tree" },
  { import = "plugins.navigation.telescope" },
}

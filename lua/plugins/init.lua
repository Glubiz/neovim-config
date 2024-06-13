return {
  -- [COSMETICS] -- 


  -- [FORMATTERS] -- 
  { import = "plugins.formatter.comform" },

  -- [LSP's] -- 
  { import = "plugins.lsp.lspconfig" },
  { import = "plugins.lsp.lspsaga" },
  { import = "plugins.lsp.rustaceanvim" },

  -- [MANAGERS] -- 
  { import = "plugins.manager.mason" },
  { import = "plugins.manager.treesitter" },

  -- [MISC] -- 
  { import = "plugins.misc.auto-save" },
  { import = "plugins.misc.cmp" },
  -- { import = "plugins.misc.copilot" },
  { import = "plugins.misc.crates" },
  { import = "plugins.misc.gitsigns" },
  { import = "plugins.misc.trouble" },

  -- [NAVIGATION] -- 
  { import = "plugins.navigation.nvim-tree" },
  { import = "plugins.navigation.telescope" },
  { import = "plugins.navigation.vim-visual-multi" },
}

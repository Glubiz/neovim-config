local plugins = {
    -- Example: GitHub Copilot
    {
      "zbirenbaum/copilot.lua",
      event = { "VimEnter" },
      config = function()
        require("copilot").setup({
          panel = { enable = false },
          suggestion = { enabled = true, keymap = { next = '<C-j>', prev = '<C-k>' } },
        })
      end,
    },
  
    -- nvim-cmp + sources
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'L3MON4D3/LuaSnip',
      },
      config = function() require('custom.completion') end,
    },
  
    -- LSP installer
    { 'williamboman/mason.nvim', cmd = 'Mason', config = true },
    { 'williamboman/mason-lspconfig.nvim', after = 'mason.nvim', config = function() require('custom.lsp') end },
  
    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function() require('custom.treesitter') end },
  
    -- Additional plugins here...
}
  
return plugins
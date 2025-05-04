require('nvim-treesitter.configs').setup({
    ensure_installed = { 'rust','javascript','typescript','html','css','yaml','json','toml' },
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = { enable = true },
    textobjects = {
      select = {
        enable = true,
        keymaps = { ['af'] = '@function.outer', ['if'] = '@function.inner' }
      }
    }
})
local M = {}

M.ui = {
    theme = "tokyonight",
    transparency = false,
}

M.options = {
    opt = {
        relativenumber = false,
        number = true,
        wrap = false,
    },
    g = {
        autoformat_enabled = true,
        mapleader = " ",
    },
}

function M.plugins()
    require("custom.plugins")
end
  
function M.mappings()
    require("custom.mappings")
end
  
function M.lsp()
    require("custom.lsp")
end
  
function M.treesitter()
    require("custom.treesitter")
end
  
function M.completion()
    require("custom.completion")
end
  
function M.autocmds()
    require("custom.autocommands")
end
  
return M
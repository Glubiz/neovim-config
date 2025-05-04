vim.g.mapleader = " "
vim.opt.termguicolors = true

require("core.lazy").setup("custom.plugins")
require("custom.chadrc")
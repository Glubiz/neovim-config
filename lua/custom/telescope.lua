local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = { ["<esc>"] = actions.close },
    },
  }
}
vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fg", ":Telescope live_grep<CR>",  { silent = true })

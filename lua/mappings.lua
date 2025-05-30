require "nvchad.mappings"
local bufnr = vim.api.nvim_get_current_buf()

local map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- GROUP: [[ CORE MAPPINGS ]]

-- Enter cmd mode with ";"
map("n", ";", ":", { desc = "Enter CMD mode" })
-- Exit insert mode with "jk"
map("i", "jk", "<ESC>")
-- Save using Ctrl+s
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>")
-- Prevent force-closing with Ctrl+z / Ctrl+Z
map("n", "<C-z>", "<nop>")
map("n", "<C-S-z>", "<nop>")
-- Remove a whole word with Ctrl+Backspace
map("i", "<C-BS>", "<Esc>cvb")
-- Prevent cursor jumping back to where selection started on yank
map("v", "y", "ygv<Esc>")
-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
map("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
map("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
-- Move lines up/down
map("n", "<A-Down>", ":m .+1<CR>")
map("n", "<A-Up>", ":m .-2<CR>")
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi")
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi")
map("v", "<A-Down>", ":m '>+1<CR>gv=gv")
map("v", "<A-Up>", ":m '<-2<CR>gv=gv")

-- GROUP: [[ PLUGIN MAPPINGS ]]

-- PLUGIN: crates
map("n", "<leader>cu", function()
    local crates = require "crates"
    crates.upgrade_all_crates()
end, { desc = "Update crates" })

-- PLUGIN: lsp-saga
map({ "n", "v" }, "cA", "<cmd>Lspsaga code_action<CR>", { desc = "LSP Code action" })
map("n", "gh", "<cmd>Lspsaga finder<CR>", { desc = "LSP Find symbol definition" })
map("n", "cr", "<cmd>Lspsaga rename<CR>", { desc = "LSP Rename in file" })
map("n", "cR", "<cmd>Lspsaga rename ++project<CR>", { desc = "LSP Rename in selected files" })
map("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "LSP Peek at definition" })
map("n", "gD", "<cmd>Lspsaga goto_definition<CR>", { desc = "LSP Go to definition" })
map("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", { desc = "LSP Go to type definition" })
map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "LSP Prev diagnostics" })
map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "LSP Next diagnostics" })
map("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { desc = "LSP Toggle outline" })
map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "LSP Hover" })
map("n", "[E", function()
  require("lspsaga.diagnostic"):goto_prev { severity = vim.diagnostic.severity.ERROR }
end, { desc = "LSP Prev error" })
map("n", "]E", function()
  require("lspsaga.diagnostic"):goto_next { severity = vim.diagnostic.severity.ERROR }
end, { desc = "LSP Next error" })

-- PLUGIN: rustaceanvim
map("n", "K", function()
    vim.cmd.RustLsp { "hover", "actions" }
end, { silent = true, buffer = bufnr, desc = "Rust Hover" })
map("n", "<leader>a", function()
    -- vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
    vim.lsp.buf.codeAction() -- if you don't want grouping.
end, { silent = true, buffer = bufnr, desc = "Rust Code actions" })

-- PLUGIN: telescope
map("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", { desc = "Telescope Find references" })
map("n", "<leader>f?", "<cmd>Telescope help_tags<CR>", { desc = "Telescope Find help tags" })
map("n", "<leader>fh", "<cmd>Telescope highlights<CR>", { desc = "Telescope Find highlights" })
map("n", "<leader>fc", "<cmd>Telescope git_commits<CR>", { desc = "Telescope Git commits" })
map("n", "<leader>f.", "<cmd>Telescope git_bcommits<CR>", { desc = "Telescope Git commits in buffer" })
map("n", "<leader>fs", "<cmd>Telescope git_status<CR>", { desc = "Telescope Git status" })

-- PLUGIN: trouble
map("n", "<leader>tt", "<cmd>TroubleToggle<CR>", { desc = "Toggle Trouble" })

-- PLUGIN: harpoon    
-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
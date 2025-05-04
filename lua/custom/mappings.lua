local map = vim.api.nvim_set_keymap
local opts = { noremap=true, silent=true }

-- Basic movements
map('n', '<Leader>h', '0', opts)
map('n', '<Leader>l', '$', opts)

-- Buffer nav
map('n', '<Tab>', ':bnext<CR>', opts)
map('n', '<S-Tab>', ':bprevious<CR>', opts)

-- Save & quit
map('n', '<Leader>w', ':w<CR>', opts)
map('n', '<Leader>q', ':q<CR>', opts)

-- Copilot toggle
map('n', '<Leader>gc', ':Copilot toggle<CR>', opts)

-- Add more mappings...
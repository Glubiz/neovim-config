local api = vim.api

-- Trim trailing whitespace on save
api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function() vim.cmd([[ %s/\s\+$//e ]]) end,
})

-- Auto-reload config
api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.lua',
  command = 'source <afile> | PackerCompile',
})


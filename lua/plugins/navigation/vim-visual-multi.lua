return {
    'mg979/vim-visual-multi',
    branch = 'master',
    config = function()
        vim.g.VM_default_mappings = 0
        vim.g.VM_maps = {
          ['Find Under'] = '<C-d>',
          ['Find Subword Under'] = '<C-d>',
        }
        vim.g.VM_custom_motions = { x = 'iw' }
        vim.g.VM_mouse_mappings = 1
    end,
}
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  desc = "Workaround for NvCheatsheet being on top of Mason float.",
  pattern = "nvcheatsheet",
  group = augroup("ui_improvements", { clear = false }),
  callback = function()
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_config(win, { zindex = 44 })
  end,
})

autocmd({ "BufEnter", "FileType" }, {
  desc = "Prevent auto-comment on new line.",
  pattern = "*",
  group = augroup("gale_nitpicks", { clear = false }),
  command = [[
    setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  ]],
})

autocmd({ "BufNewFile", "BufRead" }, {
  desc = "Add support for .mdx files.",
  pattern = { "*.mdx" },
  group = augroup("mdx_support", { clear = false }),
  callback = function()
    vim.api.nvim_set_option_value("filetype", "markdown", { scope = "local" })
  end,
})

autocmd("VimResized", {
  desc = "Auto resize panes when resizing nvim window.",
  pattern = "*",
  group = augroup("ui_improvements", { clear = false }),
  command = [[
    tabdo wincmd =
  ]],
})

autocmd("VimLeavePre", {
  desc = "Close NvimTree before quitting nvim.",
  pattern = { "<buffer>", "*" },
  group = augroup("ui_improvements", { clear = false }),
  callback = function()
    if vim.bo.filetype == "NvimTree" then
      vim.api.nvim_buf_delete(0, { force = true })
    end
  end,
})

autocmd("TextYankPost", {
  desc = "Highlight on yank.",
  group = augroup("ui_improvements", { clear = false }),
  callback = function()
    vim.highlight.on_yank { higroup = "YankVisual", timeout = 200 }
  end,
})

autocmd("ModeChanged", {
  desc = "Strategically disable diagnostics to focus on editing tasks.",
  pattern = { "n:i", "n:v", "i:v" },
  group = augroup("user_diagnostic", { clear = true }),
  callback = function()
    vim.diagnostic.disable(0)
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Disable diagnostics in node_modules.",
  pattern = "*/node_modules/*",
  group = augroup("user_diagnostic", { clear = true }),
  callback = function()
    vim.diagnostic.disable(0)
  end,
})

autocmd("ModeChanged", {
  desc = "Enable diagnostics upon exiting insert mode to resume feedback.",
  pattern = "i:n",
  group = augroup("user_diagnostic", { clear = true }),
  callback = function()
    vim.diagnostic.enable(0)
  end,
})

autocmd("BufWritePre", {
  desc = "Remove trailing whitespaces on save.",
  group = augroup("trim_whitespaces", { clear = true }),
  command = [[
    :%s/\s\+$//e
  ]],
})

autocmd("FileType", {
  desc = "Define windows to close with 'q'",
  pattern = {
    "empty",
    "help",
    "startuptime",
    "qf",
    "lspinfo",
    "man",
    "checkhealth",
    "nvcheatsheet",
    "yerbreak",
  },
  group = augroup("ui_improvements", { clear = false }),
  command = [[
    nnoremap <buffer><silent> q :close<CR>
    set nobuflisted
  ]],
})

autocmd("VimEnter", {
  desc = "Open file on creation (NvimTree).",
  group = augroup("ui_improvements", { clear = false }),
  callback = function()
    require("nvim-tree.api").events.subscribe("FileCreated", function(file)
      vim.cmd("edit " .. file.fname)
    end)
  end,
})

autocmd("BufHidden", {
  desc = "Delete [No Name] buffers.",
  group = augroup("ui_improvements", { clear = false }),
  callback = function(event)
    if event.file == "" and vim.bo[event.buf].buftype == "" and not vim.bo[event.buf].modified then
      vim.schedule(function()
        pcall(vim.api.nvim_buf_delete, event.buf, {})
      end)
    end
  end,
})

autocmd("BufEnter", {
  nested = true,
  desc = "Ensure NvimTree is focused and visible after closing last open buffer.",
  group = augroup("gale_nitpicks", { clear = false }),
  callback = function()
    local api = require "nvim-tree.api"
    -- Check if there's only one window left and the last buffer closed was a file buffer
    if #vim.api.nvim_list_wins() == 1 and api.tree.is_tree_buf() then
      -- It's necessary to defer the action to let the close event complete
      vim.defer_fn(function()
        -- Close NvimTree, ensuring it will return to the last hidden buffer
        api.tree.toggle { find_file = true, focus = true }
        -- Reopen NvimTree to ensure it's focused and visible
        api.tree.toggle { find_file = true, focus = true }
        -- Ensure NvimTree is still the active window, switch to the previous window
        vim.cmd "wincmd p"
      end, 0)
    end
  end,
})

autocmd("ModeChanged", {
  -- https://github.com/L3MON4D3/LuaSnip/issues/258
  desc = "Prevent weird snippet jumping behavior.",
  pattern = { "s:n", "i:*" },
  group = augroup("ui_improvements", { clear = false }),
  callback = function()
    if
      require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end,
})

-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  desc = "Automatically update changed file in nvim.",
  group = augroup("gale_nitpicks", { clear = false }),
  command = [[
    silent! if mode() != 'c' && !bufexists("[Command Line]") | checktime | endif
  ]],
})

-- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd("FileChangedShellPost", {
  desc = "Show notification on file change.",
  group = augroup("gale_nitpicks", { clear = false }),
  command = [[
    echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
  ]],
})
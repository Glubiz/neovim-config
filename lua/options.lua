require "nvchad.options"

local g = {
  virtual_text = true,
  bookmark_sign = "",
  skip_ts_context_commentstring_module = true,
}

local tabSize = 2

local opt = {
  encoding = "utf-8",
  fileencoding = "utf-8",
  -- Prevent issues with some language servers
  backup = false,
  swapfile = false,
  -- Always show minimum n lines after current line
  scrolloff = 10,
  -- Making sure backspace works as intended
  backspace = "indent,eol,start",
  -- True color support
  termguicolors = true,
  emoji = false,
  -- Line break/wrap behaviours
  wrap = true,
  linebreak = true,
  textwidth = 0,
  wrapmargin = 0,
  -- Indentation values
  tabstop = tabSize,
  shiftwidth = tabSize,
  expandtab = true,
  autoindent = true,
  cursorline = false,
  inccommand = "split",
  ignorecase = true,
  iskeyword = vim.opt.iskeyword:append { "_", "@", ".", "-" },
  path = ".,src**",
}

-- GROUP: [[ LOOPS ]]

for k, v in pairs(g) do
  vim.g[k] = v
end

for k, v in pairs(opt) do
  vim.opt[k] = v
end
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false

require("telescope").setup({
  defaults = { file_ignore_patterns = {
    "node_modules",
    "bin",
    "obj",
    ".next",
    ".git",
  } },
})

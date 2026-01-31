-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.guicursor = "a:ver25"
vim.opt.virtualedit = "onemore"
vim.opt.backspace = "indent,eol,start"
-- # で始まる行で改行しても自動で # を継続しない
vim.opt.formatoptions:remove({ "r", "o" })

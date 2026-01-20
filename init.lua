-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("i", "<Esc>[1;9D", "<C-o>b", { silent = true })
vim.keymap.set("i", "<Esc>[1;9C", "<C-o>w", { silent = true })

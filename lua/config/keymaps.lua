-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Visual貼り付けでヤンクを保持する
vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true, desc = "Paste without overwriting yank" })
vim.keymap.set("x", "P", '"_dP', { noremap = true, silent = true, desc = "Paste without overwriting yank" })

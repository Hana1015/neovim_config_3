-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.clipboard = "unnamedplus"
-- Normal モード：現在行のインデントを減らす
vim.keymap.set('n', '<S-Tab>', '<<', { noremap = true, silent = true })
-- Visual モード：選択範囲のインデントを減らす
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true })
-- Insert モード：現在行のインデントを減らす
vim.keymap.set('i', '<S-Tab>', '<C-d>', { noremap = true, silent = true })
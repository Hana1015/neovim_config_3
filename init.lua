-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.clipboard = "unnamedplus"

if vim.env.TMUX then
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      local content = vim.fn.getreg('"')
      local success = vim.fn.system(string.format("tmux set-buffer '%s'", content))
      if vim.v.shell_error ~= 0 then
        print("Failed to sync to tmux buffer")
      end
    end,
  })
  -- Optional: map a key to explicitly copy to system clipboard via OSC 52
  vim.keymap.set("n", "<leader>y", function()
    local content = vim.fn.getreg('"')
    -- Send via OSC 52 using printf (works in tmux with set-clipboard external)
    vim.fn.system(string.format('printf "\\033]52;c;%s\\007" | base64 -d', vim.fn.base64(content)))
  end, { silent = true })
end

-- Normal モード：現在行のインデントを減らす
vim.keymap.set('n', '<S-Tab>', '<<', { noremap = true, silent = true })
-- Visual モード：選択範囲のインデントを減らす
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true })
-- Insert モード：現在行のインデントを減らす
vim.keymap.set('i', '<S-Tab>', '<C-d>', { noremap = true, silent = true })
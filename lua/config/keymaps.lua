-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Visual貼り付けでヤンクを保持しつつ、行末まで選択した場合は改行を維持する
local function visual_paste_keep_eol()
	local reg = vim.fn.getreg("\"")
	local regtype = vim.fn.getregtype("\"")

	local mode = vim.fn.mode()
	local start_pos = vim.fn.getpos("v")
	local end_pos = vim.fn.getpos(".")

	-- normalize order
	local start_line, start_col = start_pos[2], start_pos[3]
	local end_line, end_col = end_pos[2], end_pos[3]
	if start_line > end_line or (start_line == end_line and start_col > end_col) then
		start_line, end_line = end_line, start_line
		start_col, end_col = end_col, start_col
	end

	local eol_col = vim.fn.col({ end_line, "$" }) - 1
	local ends_at_eol = end_col >= eol_col
	local is_linewise = mode == "V"
	local is_multiline = start_line ~= end_line
	local is_charwise_reg = regtype:sub(1, 1) == "v"

	if ends_at_eol and (is_linewise or is_multiline) and is_charwise_reg then
		local zreg = vim.fn.getreg("z")
		local ztype = vim.fn.getregtype("z")
		local text = reg
		if text:sub(-1) ~= "\n" then
			text = text .. "\n"
		end
		vim.fn.setreg("z", text, "l")
		vim.schedule(function()
			vim.fn.setreg("z", zreg, ztype)
		end)
		return '"_d"zP'
	end

	return '"_dP'
end

vim.keymap.set("x", "p", visual_paste_keep_eol, { noremap = true, silent = true, expr = true, desc = "Paste without overwriting yank" })
vim.keymap.set("x", "P", visual_paste_keep_eol, { noremap = true, silent = true, expr = true, desc = "Paste without overwriting yank" })

-- ノーマルモードのEnterで改行を挿入してノーマルモードに戻る
vim.keymap.set("n", "<CR>", "o<Esc>", { noremap = true, silent = true, desc = "Insert new line below" })

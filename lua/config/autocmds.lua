-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local nvim_tree_reload_group = vim.api.nvim_create_augroup("UserNvimTreeReload", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "DirChanged" }, {
	group = nvim_tree_reload_group,
	callback = function()
		local ok, api = pcall(require, "nvim-tree.api")
		if not ok then
			return
		end

		if api.tree.is_visible() then
			api.tree.reload()
		end
	end,
})

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local nvim_tree_reload_group = vim.api.nvim_create_augroup("UserNvimTreeReload", { clear = true })

local function get_nvim_tree_win()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "NvimTree" then
			return win
		end
	end

	return nil
end

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "DirChanged" }, {
	group = nvim_tree_reload_group,
	callback = function()
		local ok, api = pcall(require, "nvim-tree.api")
		if not ok then
			return
		end

		if api.tree.is_visible() then
			local tree_win = get_nvim_tree_win()
			local tree_width = tree_win and vim.api.nvim_win_get_width(tree_win) or nil
			api.tree.reload()
			if tree_win and tree_width then
				vim.defer_fn(function()
					if vim.api.nvim_win_is_valid(tree_win) then
						vim.api.nvim_win_set_width(tree_win, tree_width)
					end
				end, 10)
			end
		end
	end,
})

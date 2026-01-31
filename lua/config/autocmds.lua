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

local image_window_width_group = vim.api.nvim_create_augroup("UserImageWindowWidth", { clear = true })
local image_filetypes = {
	"png",
	"jpg",
	"jpeg",
	"gif",
	"bmp",
	"webp",
	"tiff",
	"svg",
}

local function is_image_filetype(ft)
	for _, value in ipairs(image_filetypes) do
		if value == ft then
			return true
		end
	end

	return false
end

vim.api.nvim_create_autocmd("BufWinLeave", {
	group = image_window_width_group,
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if not is_image_filetype(ft) then
			return
		end

		vim.g.image_last_window_width = vim.api.nvim_win_get_width(0)
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = image_window_width_group,
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		local width = vim.g.image_last_window_width
		if not is_image_filetype(ft) or not width then
			return
		end

		pcall(vim.api.nvim_win_set_width, 0, width)
	end,
})

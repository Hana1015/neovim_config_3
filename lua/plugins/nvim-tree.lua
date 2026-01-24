local function natural_less(a, b)
  local ia, ib = 1, 1
  local la, lb = #a, #b

  while ia <= la and ib <= lb do
    local ca = a:sub(ia, ia)
    local cb = b:sub(ib, ib)

    if ca:match("%d") and cb:match("%d") then
      local sa, ea = a:find("^%d+", ia)
      local sb, eb = b:find("^%d+", ib)
      local na = tonumber(a:sub(sa, ea))
      local nb = tonumber(b:sub(sb, eb))

      if na ~= nb then
        return na < nb
      end

      local lena = ea - sa
      local lenb = eb - sb
      if lena ~= lenb then
        return lena < lenb
      end

      ia = ea + 1
      ib = eb + 1
    else
      local la_char = ca:lower()
      local lb_char = cb:lower()

      if la_char ~= lb_char then
        return la_char < lb_char
      end

      if ca ~= cb then
        return ca < cb
      end

      ia = ia + 1
      ib = ib + 1
    end
  end

  return la < lb
end

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    vim.api.nvim_create_user_command("NvimTreeCopyPath", function()
      if vim.bo.filetype ~= "NvimTree" then
        vim.notify("NvimTree内で実行してください")
        return
      end

      local api = require("nvim-tree.api")
      local node = api.tree.get_node_under_cursor()
      if not node then
        return
      end

      local path = node.link_to or node.absolute_path
      if not path or path == "" then
        return
      end

      vim.fn.setreg('"', path)
      vim.fn.setreg("+", path)
      vim.api.nvim_exec_autocmds("TextYankPost", {
        data = { operator = "y", regname = "+", regtype = "v" },
      })
      vim.notify("コピーしました: " .. path)
    end, {})

    vim.api.nvim_create_user_command("NvimTreeCreateSubdir", function()
      if vim.bo.filetype ~= "NvimTree" then
        vim.notify("NvimTree内で実行してください")
        return
      end

      local api = require("nvim-tree.api")
      local node = api.tree.get_node_under_cursor()
      if not node or not node.absolute_path then
        return
      end

      local base = node.absolute_path
      if node.type ~= "directory" then
        base = vim.fn.fnamemodify(base, ":h")
      end

      vim.ui.input({ prompt = "Subdir name: " }, function(name)
        if not name or name == "" then
          return
        end

        name = name:gsub("^/", "")
        local path = base .. "/" .. name

        vim.fn.mkdir(path, "p")
        api.tree.reload()
        vim.notify("作成しました: " .. path)
      end)
    end, {})
  end,
  opts = {
    sort = {
      sorter = function(nodes)
        table.sort(nodes, function(a, b)
          if a.type ~= b.type then
            return a.type == "directory"
          end

          return natural_less(a.name, b.name)
        end)
      end,
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")

      local function copy_node_path()
        local node = api.tree.get_node_under_cursor()
        if not node then
          return
        end

        local path = node.link_to or node.absolute_path
        if not path or path == "" then
          return
        end

        vim.fn.setreg('"', path)
        vim.fn.setreg("+", path)
        vim.api.nvim_exec_autocmds("TextYankPost", {
          data = { operator = "y", regname = "+", regtype = "v" },
        })
        vim.notify("コピーしました: " .. path)
      end

      local function create_subdir()
        local node = api.tree.get_node_under_cursor()
        if not node or not node.absolute_path then
          return
        end

        local base = node.absolute_path
        if node.type ~= "directory" then
          base = vim.fn.fnamemodify(base, ":h")
        end

        local name = vim.fn.input("Subdir name: ")
        if name == "" then
          return
        end

        name = name:gsub("^/", "")
        local path = base .. "/" .. name

        vim.fn.mkdir(path, "p")
        api.tree.reload()
        vim.notify("作成しました: " .. path)
      end

      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set("n", "<leader>yp", copy_node_path, { buffer = bufnr, noremap = true, silent = true, desc = "Copy node path" })
      vim.keymap.set("n", "<leader>ad", create_subdir, { buffer = bufnr, noremap = true, silent = true, desc = "Add subdir" })
    end,
    hijack_netrw = true,
    filesystem_watchers = {
      enable = true,
    },
    view = {
      width = {
        min = 30,
        max = 60,
      },
      side = "left",
      preserve_window_proportions = true,
    },
    actions = {
      open_file = {
        resize_window = false,
      },
    },
    tab = {
      sync = {
        open = true,
        close = true,
      },
    },
    renderer = {
      highlight_git = true,
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
    },
  },
}

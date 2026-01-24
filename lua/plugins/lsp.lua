return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers["*"] = opts.servers["*"] or {}
      opts.servers["*"].capabilities = require("cmp_nvim_lsp").default_capabilities(opts.servers["*"].capabilities)
      opts.servers.lua_ls = opts.servers.lua_ls or {}
      opts.servers.lua_ls.settings = opts.servers.lua_ls.settings or {}
      opts.servers.lua_ls.settings.Lua = opts.servers.lua_ls.settings.Lua or {}
      opts.servers.lua_ls.settings.Lua.workspace = opts.servers.lua_ls.settings.Lua.workspace or { checkThirdParty = false }
      opts.servers.lua_ls.settings.Lua.telemetry = opts.servers.lua_ls.settings.Lua.telemetry or { enable = false }

      opts.servers.pyright = opts.servers.pyright or {}
      opts.servers.r_language_server = opts.servers.r_language_server or {}
      opts.servers.bashls = opts.servers.bashls or {}
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "r_language_server",
        "bashls",
      },
    },
  },
}

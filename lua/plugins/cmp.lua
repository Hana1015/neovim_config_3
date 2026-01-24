return {
  { import = "lazyvim.plugins.extras.coding.nvim-cmp" },
  {
    "saghen/blink.cmp",
    enabled = false,
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.sources = opts.sources or {}
      if #opts.sources == 0 then
        opts.sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        })
      end
      table.insert(opts.sources, { name = "copilot", group_index = 2 })

      opts.completion = opts.completion or {}
      opts.completion.autocomplete = { cmp.TriggerEvent.TextChanged }

      opts.mapping = cmp.mapping.preset.insert({
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      })

      cmp.setup.filetype({ "python" }, {
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "copilot", group_index = 2 },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })

      cmp.setup.filetype({ "r", "rmd" }, {
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "copilot", group_index = 2 },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })

      cmp.setup.filetype({ "sh", "bash", "zsh" }, {
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "copilot", group_index = 2 },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua", "hrsh7th/nvim-cmp" },
    event = { "InsertEnter", "LspAttach" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}

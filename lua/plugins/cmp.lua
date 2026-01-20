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
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "copilot", group_index = 2 })

      opts.mapping = opts.mapping or {}
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        else
          fallback()
        end
      end, { "i", "s" })
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

return {
  "ibhagwan/smartyank.nvim",
  event = { "TextYankPost" },
  opts = {
    highlight = {
      enabled = true,
      higroup = "IncSearch",
      timeout = 200,
    },
    clipboard = {
      enabled = true,
    },
    osc52 = {
      enabled = true,
      silent = true,
    },
  },
}

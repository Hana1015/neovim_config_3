return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    panel = { enabled = false },
    suggestion = { enabled = true },
    filetypes = {
      markdown = true,
      help = false,
    },
  },
}

return {
  "benlubas/molten-nvim",
  event = "VeryLazy",
  build = ":UpdateRemotePlugins",
  dependencies = {
    "3rd/image.nvim",
  },
  init = function()
    vim.g.molten_image_provider = "image.nvim"
    vim.g.molten_virt_text_output = true
    vim.g.molten_virt_text_max_lines = 12
    vim.g.molten_auto_open_output = false
  end,
  keys = {
    { "<localleader>mi", "<cmd>MoltenInit<cr>", desc = "Molten Init" },
    { "<localleader>e", "<cmd>MoltenEvaluateOperator<cr>", desc = "Molten Eval Operator" },
    { "<localleader>rl", "<cmd>MoltenEvaluateLine<cr>", desc = "Molten Eval Line" },
    { "<localleader>rr", "<cmd>MoltenReevaluateCell<cr>", desc = "Molten Re-eval Cell" },
    { "<localleader>rd", "<cmd>MoltenDelete<cr>", desc = "Molten Delete Cell" },
    { "<localleader>oh", "<cmd>MoltenHideOutput<cr>", desc = "Molten Hide Output" },
    { "<localleader>os", "<cmd>noautocmd MoltenEnterOutput<cr>", desc = "Molten Enter Output" },
    { "<localleader>r", ":<C-u>MoltenEvaluateVisual<cr>gv", mode = "v", desc = "Molten Eval Visual" },
  },
}

return {
  "3rd/image.nvim",
  event = "VeryLazy",
  opts = {
    backend = "sixel",
    processor = "magick_cli",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = true,
        only_render_image_at_cursor_mode = "popup",
        floating_windows = false,
        filetypes = { "markdown", "vimwiki" },
      },
      neorg = {
        enabled = true,
        filetypes = { "norg" },
      },
      typst = {
        enabled = true,
        filetypes = { "typst" },
      },
      html = { enabled = false },
      css = { enabled = false },
    },
    max_height_window_percentage = 50,
    scale_factor = 1.0,
  },
}

return {
  "3rd/image.nvim",
  event = "VeryLazy",
  opts = function()
    local backend = "sixel"

    if vim.env.KITTY_WINDOW_ID
      or vim.env.WEZTERM_EXECUTABLE
      or vim.env.TERM_PROGRAM == "WezTerm"
      or vim.env.TERM_PROGRAM == "Ghostty"
    then
      backend = "kitty"
    end

    if vim.env.TERM_PROGRAM == "iTerm.app" then
      backend = "sixel"
    end

    return {
      backend = backend,
      processor = "magick_cli",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          only_render_image_at_cursor_mode = "inline",
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
      max_height_window_percentage = 100,
      max_width_window_percentage = 100,
      scale_factor = 1.0,
      window_overlap_clear_enabled = true,
    }
  end,
}

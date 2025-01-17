return {
  -- CSV viewer
  {
    "hat0uma/csvview.nvim",
    lazy = true,
    ft = { "csv" },
    opts = {
      view = {
        min_column_width = 7,
        spacing = 4,
        display_mode = "border",
      },
    },
  },
}

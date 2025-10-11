return {
  -- CSV viewer
  {
    "hat0uma/csvview.nvim",
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
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

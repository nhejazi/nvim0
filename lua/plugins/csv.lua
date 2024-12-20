-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- CSV viewer
  {
    "hat0uma/csvview.nvim",
    config = function()
      require("csvview").setup({
        view = {
          min_column_width = 7,
          spacing = 4,
          display_mode = "border",
        },
      })
    end,
  },
}

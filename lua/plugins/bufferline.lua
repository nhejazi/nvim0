-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {

  -- TODO: fix colorscheme integration
  {
    "akinsho/bufferline.nvim",
    enabled = true,
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
  },
}

-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

-- adapted from https://github.com/lervag/vimtex?tab=readme-ov-file#lazynvim
return {
  -- markdown auto-render engine (LazyVim default)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      -- options to always show
      anti_conceal = {
        ignore = {
          code_language = true,
          code_background = true,
          code_border = true,
          quote = true,
          link = true,
        },
      },
    },
  },

  -- markdown preview engine
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    enabled = false,
  },
}

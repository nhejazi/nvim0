-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

-- adapted from https://github.com/lervag/vimtex?tab=readme-ov-file#lazynvim
return {
  -- markdown auto-render engine
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = {
      "markdown",
      "rmd",
      "quarto",
    },
    opts = {
      -- options for code display
      code = {
        style = "none",
        sign = false,
        width = 0,
        border = "none",
        right_pad = 4,
      },
      -- options to always show (never hide via local conceal behavior)
      -- anti_conceal = {
      --   ignore = {
      --     code_background = true,
      --     code_border = true,
      --     link = true,
      --   },
      -- },
    },
  },

  -- markdown viewer
  {
    "OXY2DEV/markview.nvim",
    enabled = false,
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}

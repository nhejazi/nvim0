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
      -- options to always show
      anti_conceal = {
        ignore = {
          code_language = true,
          code_background = true,
          code_border = true,
          quote = true,
          sign = true,
          link = true,
        },
      },
    },
  },
}

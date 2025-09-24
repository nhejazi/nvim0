return {
  -- lightweight code formatting (used by LazyVim as default)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        python = { "black" },
        -- r = { "air" },
        rmd = { "injected" },
        quarto = { "injected" },
      },
    },
  },
}

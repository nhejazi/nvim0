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
        sign = false,
        style = "full",
        width = "block", -- only has an effect when style = "full"
        left_pad = 0,
        right_pad = 4,
        border = "thick",
        inline_pad = 1,
      },
      latex = { enabled = false },
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
}

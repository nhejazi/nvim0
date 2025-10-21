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
      yaml = { enabled = false },
      heading = {
        enabled = true,
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      -- Make rendering more context-aware
      render_modes = { "n", "c" }, -- Only render in normal and command modes, not insert
      anti_conceal = {
        enabled = true, -- Show real text when cursor is on the line
      },
    },
  },
}

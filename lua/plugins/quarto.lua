return {
  -- for LSP-like features in code cells and embedded code
  {
    "jmbuhr/otter.nvim",
    lazy = true,
    ft = {
      "markdown",
      "rmd",
      "quarto",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      buffers = {
        -- avoid linter errors in R chunks:
        -- see https://github.com/quarto-dev/quarto-nvim/issues/84
        write_to_disk = true,
      },
      verbose = {
        no_code_found = false,
      },
    },
  },

  -- for enhanced quarto functionality, using treesitter and LSP
  {
    "quarto-dev/quarto-nvim",
    lazy = true,
    ft = { "quarto" },
    dependencies = {
      -- for language features in code cells
      "jmbuhr/otter.nvim",
    },
    opts = {},
  },
}

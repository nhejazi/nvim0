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
    opts = {
      lspFeatures = {
        -- list the embedded languages explicitly: the default (nil) means
        -- "every language treesitter finds", which pulls in `latex` from
        -- inline $...$ math. otter then hands that math to ltex as a
        -- standalone .tex document, where languagetool checks the contents
        -- of \text{} as prose and reports "Possible typo detected" spanning
        -- from line 1 to the first $. keeping `latex`/`tex` off this list is
        -- what avoids that.
        -- note: `bash` is the treesitter injection name, `sh` the filetype.
        languages = { "r", "python", "julia", "bash", "sh", "lua", "cpp" },
      },
    },
  },
}

return {
  -- lightweight code formatting (used by LazyVim as default)
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        lua = { "stylua" },
        sh = { "shfmt" },
        python = { "isort", "black" },
        r = { "air" },
        markdown = { "prettier" },
        rmd = { "prettier", "injected" },
        quarto = { "prettier", "injected" },
        yaml = { "yamlfmt" },
      })

      opts.formatters = vim.tbl_extend("force", opts.formatters or {}, {
        prettier = {
          options = {
            ext_parsers = {
              qmd = "markdown", -- .qmd as markdown
            },
          },
        },
        injected = {
          options = {
            -- set to true to ignore errors
            ignore_errors = true,
            -- map of treesitter language to filetype
            lang_to_ft = {
              bash = "sh",
              markdown = "md",
              yaml = "yml",
            },
            -- map of treesitter language to file extension
            lang_to_ext = {
              bash = "sh",
              javascript = "js",
              julia = "jl",
              latex = "tex",
              markdown = "md",
              python = "py",
              r = "R",
              ruby = "rb",
              rust = "rs",
              typescript = "ts",
            },
            -- NOTE: defaults to the value from formatters_by_ft, *see above*
            -- map of treesitter language to formatters to use
            -- lang_to_formatters = {},
          },
        },
      })

      return opts
    end,
  },
}

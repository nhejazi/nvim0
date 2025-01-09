return {
  -- add blink.compat, for compatibility with cmp  modules
  {
    "saghen/blink.compat",
    lazy = true,
    opts = {},
  },

  -- fast(er) autocompletion engine
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "saghen/blink.compat",
        -- "xzbdmw/colorful-menu.nvim",
        "giuxtaposition/blink-cmp-copilot",
        "jmbuhr/cmp-pandoc-references",
        "kdheepak/cmp-latex-symbols",
        "micangl/cmp-vimtex",
        "R-nvim/cmp-r",
      },
    },
    opts = {
      completion = {
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
      },
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "copilot",
          "rlang",
          "markdown",
          "pandoc_references",
          "latex_symbols",
          "vimtex",
        },
        providers = {
          lsp = {
            name = "LSP",
            module = "blink.cmp.sources.lsp",
            async = true,
            -- timeout_ms = 500,
          },
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 110,
            async = true,
          },
          markdown = {
            name = "markdown",
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
            score_offset = 90,
          },
          rlang = {
            name = "R",
            module = "blink.compat.source",
            score_offset = 120,
          },
          vimtex = {
            name = "vimTeX",
            module = "blink.compat.source",
            score_offset = 100,
          },
          latex_symbols = {
            name = "TeX",
            module = "blink.compat.source",
            score_offset = 100,
          },
          pandoc_references = {
            name = "bib",
            module = "blink.compat.source",
            score_offset = 100,
          },
        },
      },
    },
  },
}

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
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 6,
            async = true,
          },
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
            score_offset = 5,
          },
          rlang = {
            name = "cmp_r",
            module = "blink.compat.source",
            fallbacks = { "lsp" },
            score_offset = 7,
          },
          vimtex = {
            name = "vimtex",
            module = "blink.compat.source",
            score_offset = 5,
          },
          latex_symbols = {
            name = "latex_symbols",
            module = "blink.compat.source",
            score_offset = 5,
          },
          pandoc_references = {
            name = "pandoc_references",
            module = "blink.compat.source",
            score_offset = 5,
          },
        },
      },
    },
  },
}

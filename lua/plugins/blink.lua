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
        "giuxtaposition/blink-cmp-copilot",
        "jmbuhr/cmp-pandoc-references",
        "kdheepak/cmp-latex-symbols",
        "micangl/cmp-vimtex",
        "R-nvim/cmp-r",
      },
    },
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        ghost_text = {
          enabled = false,
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
          -- "markdown",
          "pandoc_references",
          "latex_symbols",
          "vimtex",
        },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },
          -- markdown = {
          --   name = "RenderMarkdown",
          --   module = "render-markdown.integ.blink",
          --   score_offset = 90,
          -- },
          rlang = {
            name = "cmp_r",
            module = "blink.compat.source",
            score_offset = 100,
          },
          vimtex = {
            name = "vimtex",
            module = "blink.compat.source",
            score_offset = 90,
          },
          latex_symbols = {
            name = "latex_symbols",
            module = "blink.compat.source",
            score_offset = 90,
          },
          pandoc_references = {
            name = "pandoc_references",
            module = "blink.compat.source",
            score_offset = 100,
          },
        },
      },
    },
  },
}

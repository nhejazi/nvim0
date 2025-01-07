-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
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
            score_offset = 17,
            async = true,
          },
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
            score_offset = 15,
          },
          rlang = {
            name = "cmp_r",
            module = "blink.compat.source",
            score_offset = 20,
          },
          vimtex = {
            name = "vimtex",
            module = "blink.compat.source",
            score_offset = 15,
          },
          latex_symbols = {
            name = "latex_symbols",
            module = "blink.compat.source",
            score_offset = 10,
          },
          pandoc_references = {
            name = "pandoc_references",
            module = "blink.compat.source",
            score_offset = 10,
          },
        },
      },
    },
  },
}

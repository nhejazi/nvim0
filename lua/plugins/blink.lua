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
        "giuxtaposition/blink-cmp-copilot",
        "jmbuhr/cmp-pandoc-references",
        "kdheepak/cmp-latex-symbols",
        "micangl/cmp-vimtex",
      },
    },
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot", "vimtex", "pandoc_references" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },
          vimtex = {
            name = "vimtex",
            module = "blink.compat.source",
            score_offset = 100,
          },
          latex_symbols = {
            name = "latex_symbols",
            module = "blink.compat.source",
            score_offset = 100,
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

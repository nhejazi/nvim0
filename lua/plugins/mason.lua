-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "tree-sitter-cli",
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "black",
        "r-languageserver",
        "julia-lsp",
        "marksman",
        "texlab",
        "jupytext",
        "proselint",
      },
    },
  },
}

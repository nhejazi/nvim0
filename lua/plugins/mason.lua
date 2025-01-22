return {
  {
    "williamboman/mason.nvim",
    -- add tools to be installed below (installs in a virtualenv)
    opts = {
      ensure_installed = {
        "tree-sitter-cli",
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "black",
        "pyright",
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

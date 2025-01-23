return {
  {
    "williamboman/mason.nvim",
    -- add tools to be installed below (installs in a virtualenv)
    opts = {
      ensure_installed = {
        "tree-sitter-cli",
        -- lsp servers
        "basedpyright",
        "julia-lsp",
        "ltex-ls",
        "marksman",
        "python-lsp-server",
        "r-languageserver",
        "texlab",
        -- linting
        "flake8",
        "proselint",
        "shellcheck",
        "vale",
        -- formatting
        "black",
        "jupytext",
        "shfmt",
        "stylua",
      },
    },
  },
}

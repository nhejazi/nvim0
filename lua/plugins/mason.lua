return {
  {
    "williamboman/mason.nvim",
    -- add tools to be installed below (done in a virtualenv)
    opts = {
      ensure_installed = {
        "tree-sitter-cli",
        -- lsp servers
        "basedpyright",
        "julia-lsp",
        "ltex-ls", -- NOTE: ltex-ls-plus (better maintained) not yet supported
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

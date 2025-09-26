return {
  {
    "mason-org/mason.nvim",
    -- add tools to be installed below (done in a virtualenv)
    opts = {
      ensure_installed = {
        "tree-sitter-cli",
        -- lsp servers
        "basedpyright",
        "julia-lsp",
        "ltex-ls",
        "ltex-ls-plus",
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
        "air",
        "black",
        "jupytext",
        "markdown-oxide",
        "shfmt",
        "stylua",
      },
    },
  },
}

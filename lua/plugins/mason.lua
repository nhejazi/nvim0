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
        -- "ltex-ls",
        "ltex-ls-plus",
        "marksman",
        "markdown-oxide",
        "python-lsp-server",
        "r-languageserver",
        "texlab",
        "yaml-language-server",
        -- linting
        "flake8",
        "proselint",
        "shellcheck",
        "vale",
        -- formatting
        "air",
        "black",
        "isort",
        "jupytext",
        "markdown-oxide",
        "prettier",
        "shfmt",
        "stylua",
        "yamlfmt",
      },
    },
  },
}

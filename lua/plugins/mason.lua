return {
  {
    "williamboman/mason.nvim",
    -- add any tools you want to have installed below
    opts = {
      ensure_installed = {
        "tree-sitter-cli",
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "black",
        -- "r-languageserver",  -- disable to avoid clashing with cmp-r
        "julia-lsp",
        "marksman",
        "texlab",
        "jupytext",
        "proselint",
      },
    },
  },
}

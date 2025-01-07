return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "csv",
        "dot",
        "html",
        "javascript",
        "json",
        "julia",
        "latex", -- requires tree-sitter-cli, auto-installed via Mason
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "mermaid",
        "python",
        "r",
        "rnoweb",
        "regex",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
}

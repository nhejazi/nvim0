-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add more treesitter parsers
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

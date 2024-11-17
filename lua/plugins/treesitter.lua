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
        "dot",
        "html",
        "javascript",
        "json",
        "julia",
        "latex", -- requires treesitter-cli, auto-installed via Mason
        "lua",
        "markdown",
        "markdown_inline",
        "mermaid",
        "python",
        "r",
        "rnoweb",
        "regex",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
}

-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- github PRs and the like with gh-cli
  {
    "pwntester/octo.nvim",
    enabled = true,
    cmd = "Octo",
    config = function()
      require("octo").setup()
      vim.keymap.set("n", "<leader>gpl", ":Octo pr list<cr>", {
        desc = "octo [p]r list",
      })
      vim.keymap.set("n", "<leader>gpr", ":Octo review start<cr>", {
        desc = "octo [r]eview",
      })
    end,
  },
}

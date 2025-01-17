return {
  -- interactive and powerful git interface for neovim
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional: diff integration
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },
}

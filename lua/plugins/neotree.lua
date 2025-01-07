return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true, -- default is false
      window = {
        position = "left",
        width = 29, -- default is 40
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignore = false,
          never_show = {
            ".git",
            ".DS_Store",
          },
        },
      },
    },
  },
}

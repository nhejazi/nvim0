-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
  },

  -- add nord
  {
    "shaunsingh/nord.nvim",
  },

  -- add ashen
  {
    "ficcdaf/ashen.nvim",
  },

  -- add rose pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "moon",
    },
  },

  -- add tokyo night
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
    },
  },

  -- Configure LazyVim to load colorscheme of choice
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}

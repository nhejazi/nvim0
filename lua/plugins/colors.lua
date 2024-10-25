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

  -- add rose pine
  {
    "rose-pine/neovim",
  },

  -- add tokyo night
  {
    "folke/tokyonight.nvim",
  },

  -- Configure LazyVim to load nord
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord"
    },
  },
}

return {
  -- gruvbox: https://github.com/ellisonleao/gruvbox.nvim
  {
    "ellisonleao/gruvbox.nvim",
    enabled = false,
  },

  -- nord: https://github.com/shaunsingh/nord.nvim
  {
    "shaunsingh/nord.nvim",
    enabled = false,
  },

  -- ashen: https://github.com/ficcdaf/ashen.nvim
  {
    "ficcdaf/ashen.nvim",
    enabled = false,
  },

  -- rosé pine: https://github.com/rose-pine/neovim
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "moon",
    },
  },

  -- tokyo night: https://github.com/folke/tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
    },
    enabled = false,
  },

  -- load colorscheme of choice
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}

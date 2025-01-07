return {
  -- adapted from https://github.com/lervag/vimtex?tab=readme-ov-file#lazynvim
  {
    "lervag/vimtex",
    lazy = false,
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
    end,
  },
}

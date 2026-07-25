return {
  -- adapted from https://github.com/lervag/vimtex?tab=readme-ov-file#lazynvim
  {
    "lervag/vimtex",
    lazy = false,
    config = function()
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
      vim.g.vimtex_view_method = "general"
    end,
  },
}

-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- highlight colors
  {
    "norcalli/nvim-colorizer.lua",
  },

  -- high auto-completion menu
  {
    "xzbdmw/colorful-menu.nvim",
    enabled = false,
    config = {
      ls = {
        lua_ls = {
          -- Maybe you want to dim arguments a bit.
          arguments_hl = "@comment",
        },
        gopls = {
          add_colon_before_type = false,
        },
        -- for lsp_config or typescript-tools
        ts_ls = {
          extra_info_hl = "@comment",
        },
        vtsls = {
          extra_info_hl = "@comment",
        },
        ["rust-analyzer"] = {
          -- Such as (as Iterator), (use std::io).
          extra_info_hl = "@comment",
        },
        clangd = {
          -- Such as "From <stdio.h>".
          extra_info_hl = "@comment",
        },
        roslyn = {
          extra_info_hl = "@comment",
        },
        basedpyright = {
          -- It is usually import path such as "os"
          extra_info_hl = "@comment",
        },

        -- If true, try to highlight "not supported" languages.
        fallback = true,
      },
      -- If the built-in logic fails to find a suitable highlight group,
      -- this highlight is applied to the label.
      fallback_highlight = "@variable",
      -- If provided, the plugin truncates the final displayed text to
      -- this width (measured in display cells). Any highlights that extend
      -- beyond the truncation point are ignored. Default 60.
      max_width = 60,
    },
  },
}

-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

-- adapted from README of https://github.com/R-nvim/R.nvim
return {

  {
    "R-nvim/R.nvim",
     -- only required if you also set defaults.lazy = true
    lazy = false,
    -- R.nvim is still young and we may make some breaking changes from time
    -- to time. For now we recommend pinning to the latest minor version:
    version = "~0.1.0",
    config = function()
      -- create a table with the options to be passed to setup()
      local opts = {
        hook = {
          on_filetype = function()
            vim.api.nvim_buf_set_keymap(
              0, "n", "<Enter>", "<Plug>RDSendLine", {}
            )
            vim.api.nvim_buf_set_keymap(
              0, "v", "<Enter>", "<Plug>RSendSelection", {}
            )
          end
        },
        R_app = "radian",
        R_cmd = "R",
        R_args = {"--quiet", "--no-save"},
        min_editor_width = 81,
        rconsole_width = 72,
        bracketed_paste = true,
        disable_cmds = {
          "RClearConsole",
          "RCustomStart",
          "RSPlot",
          "RSaveClose",
        },
      }
      require("r").setup(opts)
    end,
  },

}

return {
  -- R auto-completion engine
  {
    "R-nvim/cmp-r",
    lazy = true,
  },

  -- REPL support for R
  {
    "R-nvim/R.nvim",
    lazy = false,
    -- devs recommend pinning to the latest minor version:
    version = "~0.1.0",
    opts = {
      hook = {
        on_filetype = function()
          vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
          vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
        end,
      },
      -- R_app = "radian",
      R_cmd = "R",
      R_args = { "--quiet", "--no-save" },
      rmdchunk = "``",
      rconsole_width = 70,
      min_editor_width = 81,
      assignment_keymap = "_",
      -- bracketed_paste = true,
      pdfviewer = "",
      open_pdf = "open",
      disable_cmds = {
        "RClearConsole",
        "RCustomStart",
        "RSPlot",
        "RSaveClose",
      },
    },
  },
}

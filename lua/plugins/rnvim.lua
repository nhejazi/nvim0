return {
  -- R auto-completion engine
  {
    "R-nvim/cmp-r",
    opts = {
      doc_width = 70,
      trigger_characters = { " ", ":", "(", '"', "$" },
    },
  },

  -- REPL support for R
  {
    "R-nvim/R.nvim",
    -- recommended: pin to the latest minor version
    version = "~0.1.0",
    opts = {
      hook = {
        on_filetype = function()
          vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
          vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
        end,
      },
      -- R_app = "radian",
      -- bracketed_paste = true,
      R_cmd = "R",
      R_args = { "--quiet", "--no-save" },
      rmdchunk = "``",
      rconsole_width = 70,
      min_editor_width = 81,
      assignment_keymap = "_",
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

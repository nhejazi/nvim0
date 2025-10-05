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
    lazy = false,
    opts = {
      hook = {
        on_filetype = function()
          vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "i", "_", "<Plug>RInsertAssign", { noremap = true })
        end,
      },
      R_cmd = "R",
      R_args = { "--quiet", "--no-save" },
      -- R_app = "radian", -- radian repl and renv together cause segfault
      -- bracketed_paste = true, -- need to pass code blocks to for radian repl
      min_editor_width = 81,
      rconsole_width = 70,
      pdfviewer = "", -- default pdf viewer
      open_pdf = "open", -- keep focus on terminal when opening pdf
      disable_cmds = {
        "RClearConsole",
        "RCustomStart",
        "RSPlot",
        "RSaveClose",
      },
      quarto_chunk_hl = {
        highlight = true,
        yaml_hl = true,
      },
    },
  },
}

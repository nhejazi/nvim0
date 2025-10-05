return {
  -- send code from python/R/qmd files to a REPL, e.g., ipython, R, shell
  -- from https://codeberg.org/pjphd/neovim_config/src/branch/main/lua/plugins/iron.lua
  {
    "Vigemus/iron.nvim",
    config = function()
      local iron = require("iron.core")
      iron.setup({
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true, -- whether a repl should be discarded or not
          repl_definition = {
            R = {
              command = { "R --quiet --no-save" },
            },
            r = {
              command = { "R --quiet --no-save" },
            },
            quarto = {
              command = { "R --quiet --no-save" },
            },
          },
          repl_open_cmd = require("iron.view").split.vertical.botright("40%"),
        },
        -- iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = "<localleader> <Enter>",
          visual_send = "<localleader> <Enter>",
          send_file = "<localleader>f<space>",
          send_line = "<localleader>l<space>",
          send_paragraph = "<localleader>p<space>",
          send_until_cursor = "<localleader>;<space>",
          -- send_mark = "<localleader>rm",
          -- mark_motion = "<localleader>mc",
          -- mark_visual = "<localleader>mc",
          -- remove_mark = "<localleader>md",
          cr = "<localleader>rA<cr>",
          interrupt = "<localleader>cc",
          exit = "<localleader>rQ",
          clear = "<localleader>rC",
        },
        highlight = false,
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      })

      -- iron also has a list of commands, see :h iron-commands for all available commands
      vim.keymap.set("n", "<localleader>;F", "<cmd>IronRepl<cr>", { desc = "[R]EPL [S]tart" })
      vim.keymap.set("n", "<localleader>;R", "<cmd>IronRestart<cr>", { desc = "[R]EPL [R]estart" })
      vim.keymap.set("n", "<localleader>;S", "<cmd>IronFocus<cr>", { desc = "[R]EPL [F]ocus" })
      vim.keymap.set("n", "<localleader>;H", "<cmd>IronHide<cr>", { desc = "[R]EPL [H]ide" })
    end,
  },
}

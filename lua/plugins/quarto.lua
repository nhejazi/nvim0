return {
  -- for LSP-like features in code cells and embedded code
  {
    "jmbuhr/otter.nvim",
    lazy = true,
    ft = {
      "markdown",
      "rmd",
      "quarto",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      buffers = {
        -- avoid linter errors in R chunks:
        -- see https://github.com/quarto-dev/quarto-nvim/issues/84
        write_to_disk = true,
      },
      verbose = {
        no_code_found = false,
      },
    },
  },

  -- for enhanced quarto functionality, using treesitter and LSP
  {
    "quarto-dev/quarto-nvim",
    lazy = true,
    ft = { "quarto" },
    dependencies = {
      -- for language features in code cells
      "jmbuhr/otter.nvim",
    },
    opts = {},
  },

  -- send code from python/R/qmd files to a REPL, e.g., ipython, R, shell
  -- TODO: set up to replace vim-slime for R, python, julia
  --       see https://github.com/Vigemus/iron.nvim/discussions/319
  {
    "Vigemus/iron.nvim",
    enabled = false,
    cmd = {
      "IronRepl",
      "IronReplHere",
      "IronRestart",
      "IronSend",
      "IronFocus",
      "IronHide",
      "IronWatch",
      "IronAttach",
    },
    keys = {
      "<space>sc",
      "<space>sc",
      "<space>sf",
      "<space>sl",
      "<space>su",
      "<space>sm",
      "<space>mc",
      "<space>mc",
      "<space>md",
      "<space>s<cr>",
      "<space>s<space>",
      "<space>sq",
      "<space>cl",

      { "<space>rs", "<cmd>IronRepl<cr>" },
      { "<space>rr", "<cmd>IronRestart<cr>" },
      { "<space>rf", "<cmd>IronFocus<cr>" },
      { "<space>rh", "<cmd>IronHide<cr>" },
    },
    main = "iron.core", -- <== This informs lazy.nvim to use the entrypoint of `iron.core` to load the configuration.
    opts = {
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          sh = {
            -- Can be a table or a function that
            -- returns a table (see below)
            command = { "fish" },
          },
        },
        -- How the repl window will be displayed
        -- See below for more information
        -- repl_open_cmd = require('iron.view').bottom(40),
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {
        send_motion = "<space>sc",
        visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_until_cursor = "<space>su",
        send_mark = "<space>sm",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = { italic = true },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    },
  },

  -- send code from python/R/qmd files to a REPL, e.g., ipython, R, shell
  {
    "jpalardy/vim-slime",
    init = function()
      vim.b["quarto_is_python_chunk"] = false
      Quarto_is_in_python_chunk = function()
        require("otter.tools.functions").is_otter_language_context("python")
      end

      vim.cmd([[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists("g:slime_python_ipython") && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists("b:quarto_is_r_mode") && b:quarto_is_r_mode)
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      if exists("b:quarto_is_r_mode") && b:quarto_is_r_mode && b:quarto_is_python_chunk
      return [a:text, "\n"]
      else
      return [a:text]
      end
      end
      endfunction
      ]])

      vim.g.slime_target = "neovim"
      vim.g.slime_no_mappings = true
      vim.g.slime_python_ipython = 1
    end,
    config = function()
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = true

      local function mark_terminal()
        local job_id = vim.b.terminal_job_id
        vim.print("job_id: " .. job_id)
      end

      local function set_terminal()
        vim.fn.call("slime#config", {})
      end
      vim.keymap.set("n", "<leader>cm", mark_terminal, { desc = "[m]ark terminal" })
      vim.keymap.set("n", "<leader>cs", set_terminal, { desc = "[s]et terminal" })
    end,
  },
}

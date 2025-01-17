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

  -- open jupyter notebooks as quarto and convert back behind the scenes
  {
    "GCBallesteros/jupytext.nvim",
    lazy = true,
    opts = {
      custom_language_formatting = {
        python = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
        r = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
      },
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

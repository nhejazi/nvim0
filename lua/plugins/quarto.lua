-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

-- modified from https://github.com/jmbuhr/quarto-nvim-kickstarter/blob/main/lua/plugins/quarto.lua
return {
  -- for lsp-like features in code cells and embedded code
  {
    "jmbuhr/otter.nvim",
    dev = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      buffers = {
        -- avoid linter errors in R chunks
        -- see https://github.com/quarto-dev/quarto-nvim/issues/84
        write_to_disk = true,
      },
      verbose = {
        no_code_found = false,
      },
    },
  },

  -- for enhanced quarto functionality, using treesitter and lsp
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto" },
    dev = false,
    opts = {},
    dependencies = {
      -- for language features in code cells
      -- configured in lsp.lua and added as a nvim-cmp source in base.lua
      "jmbuhr/otter.nvim",
    },
  },

  -- directly open ipynb files as quarto and convert back behind the scenes
  {
    "GCBallesteros/jupytext.nvim",
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

  -- send code from python/R/qmd documents to a REPL like ipython, R, bash
  {
    "jpalardy/vim-slime",
    dev = false,
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

  -- preview equations
  {
    "jbyuki/nabla.nvim",
    keys = {
      { "<leader>qm", ":lua require'nabla'.toggle_virt()<cr>", desc = "toggle [m]ath equations" },
    },
  },

  -- interactively running code using a jupyter kernel
  {
    "benlubas/molten-nvim",
    enabled = false,
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
    end,
    keys = {
      { "<leader>mi", ":MoltenInit<cr>", desc = "[m]olten [i]nit" },
      {
        "<leader>mv",
        ":<C-u>MoltenEvaluateVisual<cr>",
        mode = "v",
        desc = "molten eval visual",
      },
      { "<leader>mr", ":MoltenReevaluateCell<cr>", desc = "molten re-eval cell" },
    },
  },
}

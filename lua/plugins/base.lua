-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- override nvim-cmp to add cmp-xxx sources
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "ray-x/cmp-treesitter",
      "kdheepak/cmp-latex-symbols",
      "jmbuhr/cmp-pandoc-references",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "jmbuhr/otter.nvim",
      {"windwp/nvim-autopairs", opts = { fast_wrap = {}, },
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require "cmp"
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      -- from https://github.com/dpetka2001/dotfiles/blob/10d02517395783adb31bffab5447437b8f908e15/dot_config/nvim/lua/plugins/coding.lua#L47-L62
      local types = require("cmp.types")
      -- Function to sort LSP snippets, so that they appear at the end of LSP
      -- suggestions
      local function deprioritize_snippet(entry1, entry2)
        if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
          return false
        end
        if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
          return true
        end
      end

      -- Insert `deprioritize_snippet` first in the `comparators` table, so
      -- that it has priority over the other default comparators
      table.insert(opts.sorting.comparators, 1, deprioritize_snippet)

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- snippet to confirm with tab
          -- see https://github.com/LazyVim/LazyVim/discussions/250
          -- (note: if no entry is selected, confirm first item)
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            else
              cmp.confirm()
            end
          else
            fallback()
          end
        end, { "i", "s", "c" }),
        ["<CR>"] = cmp.mapping(function(fallback)
          cmp.abort()
          fallback()
        end, { "i", "s", "c" }),
      })
    end,
  },

  -- GitHub copilot
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    config = function()
      require("copilot").setup {
        panel = {
          enabled = true,
          auto_trigger = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
      }
    end,
  },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "black",
      },
    },
  },

  -- TODO: consider disabling
  {
    "folke/trouble.nvim",
    enabled = true,
  },

  -- use mini.starter instead of alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },
}

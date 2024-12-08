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
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-path",
      -- "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      -- "hrsh7th/cmp-emoji",
      "ray-x/cmp-treesitter",
      "zbirenbaum/copilot-cmp",
      "kdheepak/cmp-latex-symbols",
      "jmbuhr/cmp-pandoc-references",
      "micangl/cmp-vimtex",
      "brenoprata10/nvim-highlight-colors",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      { "windwp/nvim-autopairs", opts = { fast_wrap = {} } },
    },

    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local highlight = require("nvim-highlight-colors")

      -- from https://www.lazyvim.org/configuration/recipes#supertab
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- replace select_next_item() with confirm({ select = true }) for
            -- VSCode-like autocompletion
            cmp.select_next_item()
            -- cmp.confirm({ select = true })
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      -- add cmp-xxx sources per https://www.lazyvim.org/configuration/recipes#add-a-nvim-cmp-source
      table.insert(opts.sources, 1, {
        name = "copilot",
        group_index = 2,
      })
      table.insert(opts.sources, 1, {
        name = "vimtex",
        group_index = 2,
      })
      table.insert(opts.sources, 1, {
        name = "pandoc_references",
        group_index = 2,
      })
      table.insert(opts.sources, 1, {
        name = "latex_symbols",
        group_index = 2,
        option = { strategy = 2 },
      })
      table.insert(opts.sources, 1, {
        name = "treesitter",
        group_index = 2,
      })
      table.insert(opts.sources, 1, {
        name = "luasnip",
        group_index = 2,
        option = { use_show_condition = false },
      })
      table.insert(opts.sources, 1, {
        name = "path",
        group_index = 2,
      })
      table.insert(opts.sources, 1, {
        name = "calc",
        group_index = 2,
      })

      -- highlighting
      opts.formatting = vim.tbl_extend("force", opts.formatting, {
        format = highlight.format,
      })
    end,
  },
}

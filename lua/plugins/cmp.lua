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
      { "windwp/nvim-autopairs", opts = { fast_wrap = {} } },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- snippet to confirm with tab
          -- see https://github.com/LazyVim/LazyVim/discussions/250
          -- (note: if no entry is selected, confirm first item)
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
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

      for _, source in ipairs(opts.sources) do
        if source.name == "luasnip" then
          source.option = { use_show_condition = true }
          source.entry_filter = function()
            local context = require("cmp.config.context")
            local string_ctx = context.in_treesitter_capture("string")
              or context.in_syntax_group("String")
            local comment_ctx = context.in_treesitter_capture("comment")
              or context.in_syntax_group("Comment")

            -- Returning `true` keeps the entry while  `false` removes it
            return not string_ctx and not comment_ctx
          end
        end

        if source.name == "nvim_lsp" then
          source.entry_filter = function()
            local types = require("cmp.types")
            return types.lsp.CompletionItemKind[entry:get_kind()] ~= "Snippet"
          end
        end
      end
    end,
  },
}

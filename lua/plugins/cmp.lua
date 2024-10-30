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
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "ray-x/cmp-treesitter",
      "kdheepak/cmp-latex-symbols",
      "jmbuhr/cmp-pandoc-references",
      -- "brenoprata10/nvim-highlight-colors",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "jmbuhr/otter.nvim",
      { "windwp/nvim-autopairs", opts = { fast_wrap = {} } },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      -- from https://www.lazyvim.org/configuration/recipes#supertab
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api
              .nvim_buf_get_lines(0, line - 1, line, true)[1]
              :sub(col, col)
              :match("%s")
            == nil
      end
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- replace select_next_item() with confirm({ select = true }) for
            -- VSCode autocompletion behavior
            cmp.select_next_item()
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

      --[[
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
            return types.lsp.CompletionItemKind[source.entry:get_kind()]
              ~= "Snippet"
          end
        end
      end
      --]]
    end,
  },
}

-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  --[[
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set(
            "n", "<leader>co", "TypescriptOrganizeImports", {
            buffer = buffer, desc = "Organize Imports"
          })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", {
            desc = "Rename File",
            buffer = buffer,
          })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      servers = {
        -- automatically installed with mason and loaded with lspconfig
        tsserver = {},
        -- add pyright to lspconfig
        pyright = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, may use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- use mini.starter instead of alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },
  --]]

}

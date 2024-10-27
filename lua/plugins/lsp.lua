-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  --[[
  -- add tsserver and setup with typescript.nvim instead of lspconfig
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
  --]]

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          "black",
          "stylua",
          "shfmt",
          "isort",
          "tree-sitter-cli",
          "jupytext",
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup(
          "kickstart-lsp-attach",
          { clear = true }
        ),
        callback = function(event)
          local function map(keys, func, desc)
            vim.keymap.set(
              "n",
              keys,
              func,
              { buffer = event.buf, desc = "LSP: " .. desc }
            )
          end
          local function vmap(keys, func, desc)
            vim.keymap.set(
              "v",
              keys,
              func,
              { buffer = event.buf, desc = "LSP: " .. desc }
            )
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          assert(client, "LSP client not found")

          ---@diagnostic disable-next-line: inject-field
          client.server_capabilities.document_formatting = true

          map("gS", vim.lsp.buf.document_symbol, "[g]o so [S]ymbols")
          map("gD", vim.lsp.buf.type_definition, "[g]o to type [D]efinition")
          map("gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
          map("K", vim.lsp.buf.hover, "[K] hover documentation")
          map("gh", vim.lsp.buf.signature_help, "[g]o to signature [h]elp")
          map("gI", vim.lsp.buf.implementation, "[g]o to [I]mplementation")
          map("gr", vim.lsp.buf.references, "[g]o to [r]eferences")
          map("[d", function()
            vim.diagnostic.jump({ count = 1 })
          end, "previous [d]iagnostic ")
          map("]d", function()
            vim.diagnostic.jump({ count = -1 })
          end, "next [d]iagnostic ")
          map("<leader>ll", vim.lsp.codelens.run, "[l]ens run")
          map("<leader>lR", vim.lsp.buf.rename, "[l]sp [R]ename")
          map("<leader>lf", vim.lsp.buf.format, "[l]sp [f]ormat")
          vmap("<leader>lf", vim.lsp.buf.format, "[l]sp [f]ormat")
          map(
            "<leader>lq",
            vim.diagnostic.setqflist,
            "[l]sp diagnostic [q]uickfix"
          )
        end,
      })

      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend(
        "force",
        capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- also needs:
      -- $home/.config/marksman/config.toml :
      -- [core]
      -- markdown.file_extensions = ["md", "markdown", "qmd"]
      lspconfig.marksman.setup({
        capabilities = capabilities,
        filetypes = { "markdown", "quarto" },
        root_dir = util.root_pattern(".git", ".marksman.toml", "_quarto.yml"),
      })

      lspconfig.r_language_server.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          r = {
            lsp = {
              rich_documentation = false,
            },
          },
        },
      })

      lspconfig.cssls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
      })

      lspconfig.html.setup({
        capabilities = capabilities,
        flags = lsp_flags,
      })

      lspconfig.emmet_language_server.setup({
        capabilities = capabilities,
        flags = lsp_flags,
      })

      lspconfig.yamlls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          yaml = {
            schemaStore = {
              enable = true,
              url = "",
            },
          },
        },
      })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
      })

      lspconfig.dotls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
      })

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = { "js", "javascript", "typescript", "ojs" },
      })

      local function get_quarto_resource_path()
        local function strsplit(s, delimiter)
          local result = {}
          for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
            table.insert(result, match)
          end
          return result
        end

        local f = assert(io.popen("quarto --paths", "r"))
        local s = assert(f:read("*a"))
        f:close()
        return strsplit(s, "\n")[2]
      end

      local lua_library_files = vim.api.nvim_get_runtime_file("", true)
      local lua_plugin_paths = {}
      local resource_path = get_quarto_resource_path()
      if resource_path == nil then
        vim.notify_once("quarto not found, lua library files not loaded")
      else
        table.insert(lua_library_files, resource_path .. "/lua-types")
        table.insert(
          lua_plugin_paths,
          resource_path .. "/lua-plugin/plugin.lua"
        )
      end

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            runtime = {
              version = "LuaJIT",
              -- plugin = lua_plugin_paths, -- handled by lazydev
            },
            diagnostics = {
              disable = { "trailing-space" },
            },
            workspace = {
              -- library = lua_library_files, -- handled by lazydev
              checkThirdParty = false,
            },
            doc = {
              privateName = { "^_" },
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      lspconfig.vimls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
      })

      lspconfig.julials.setup({
        capabilities = capabilities,
        flags = lsp_flags,
      })

      lspconfig.bashls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = { "sh", "bash" },
      })

      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              enable = false,
            },
          },
        },
      })
    end,
  },

  {
    -- for lsp features in code cells / embedded code
    "jmbuhr/otter.nvim",
    dev = false,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
    },
    opts = {
      verbose = {
        no_code_found = false,
      },
    },
  },
}

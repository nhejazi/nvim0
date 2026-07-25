return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      { "mason-org/mason-lspconfig.nvim", config = function() end },
    },
    opts = {
      -- modify LSP servers
      servers = {
        html = {
          init_options = {
            provideFormatter = false,
          },
        },
        -- LaTeX spell checker
        -- ltex = {
        --   -- see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ltex>
        -- filetypes = { "tex", "latex", "markdown", "md", "quarto", "rmd", "rnoweb" },
        --   settings = {
        --     ltex = {
        --       language = "en-US",
        --       checkFrequency = "save",
        --       disabledRules = {
        --         ["en-US"] = { "WHITESPACE_RULE", "PLUS_MINUS" },
        --       },
        --     },
        --   },
        -- },
        ltex_plus = {
          -- see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ltex_plus>
          filetypes = { "bib", "tex", "latex", "markdown", "md", "quarto", "rmd", "rnoweb", "text", "txt" },
          settings = {
            ltex = {
              language = "en-US",
              checkFrequency = "save",
              disabledRules = {
                ["en-US"] = { "WHITESPACE_RULE", "PLUS_MINUS" },
              },
              enabled = { "bib", "tex", "latex", "markdown", "md", "quarto", "rmd", "rnoweb", "text", "txt" },
            },
          },
        },

        -- markdown LSP (with Quarto support)
        marksman = {
          -- see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#marksman>
          cmd = { "marksman", "server" },
          filetypes = { "quarto" }, -- extend to include quarto
        },

        -- PKM markdown LSP (like obsidian)
        markdown_oxide = {
          cmd = { "markdown-oxide" },
          filetypes = { "markdown" },
        },

        -- LaTeX LSP
        texlab = {
          -- see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#texlab>
          settings = {
            texlab = {
              bibtexFormatter = "latexindent",
              latexFormatter = "latexindent",
              formatterLineLength = 79,
              diagnostics = {
                ignoredPatterns = { "Unused label", "Unused entry" },
              },
            },
          },
        },

        -- R LSP (with Quarto support)
        r_language_server = {
          -- see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#r_language_server>
          cmd = { "R", "--no-echo", "--slave", "-e", "languageserver::run()" },
          filetypes = { "r", "rmd", "quarto" }, -- extend to include quarto
          capabilities = {
            documentFormattingProvider = false, -- disable R LSP formatting
            documentRangeFormattingProvider = false,
          },
          settings = {
            r = {
              lsp = {
                debug = false,
                diagnostics = true,
                rich_documentation = false,
              },
            },
          },
        },

        -- Python LSP (main)
        basedpyright = {
          -- see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#basedpyright>
          settings = {
            basedpyright = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },

        -- Python LSP (disabled in favor of basedpyright above)
        pylsp = { enabled = false },

        -- Julia LSP
        julials = {},
      },
    },
  },
}

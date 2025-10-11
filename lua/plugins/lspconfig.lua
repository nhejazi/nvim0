return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      { "mason-org/mason-lspconfig.nvim", config = function() end },
    },
    opts = function(_, opts)
      -- modify LSP servers
      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        -- LaTeX spell checker
        ltex = {
          -- see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ltex>
          settings = {
            ltex = {
              language = "en-US",
              checkFrequency = "save",
              disabledRules = {
                ["en-US"] = { "WHITESPACE_RULE", "PLUS_MINUS" },
              },
            },
          },
        },

        -- markdown LSP (with Quarto support)
        marksman = {
          -- see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#marksman>
          filetypes = { "markdown", "quarto" }, -- extend to include quarto
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern(".marksman.toml", "_quarto.yml", ".git")(fname)
          end,
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

        -- Python LSP (alternatives)
        pylsp = {
          -- see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#pylsp>
          settings = {
            pylsp = {
              -- see <https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md>
              configurationSources = { "flake8" },
              plugins = {
                autopep8 = { enabled = false },
                flake8 = {
                  enabled = false,
                  -- see <https://www.flake8rules.com/> for PEP codes
                  -- ignore = { "E501", "E231" },
                  maxLineLength = 80,
                },
                mccabe = { enabled = true },
                pycodestyle = {
                  enabled = false,
                  -- ignore = { "E501", "E231" },
                  maxLineLength = 80,
                },
                pyflakes = { enabled = false },
                yapf = { enabled = true },
              },
            },
          },
        },

        -- Julia LSP
        julials = {},

        -- yaml LSP
        yamlls = {},
      })

      return opts
    end,
  },
}

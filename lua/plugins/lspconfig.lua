return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    opts = function(_, opts)
      -- modify LSP servers
      opts.servers = vim.tbl_deep_extend("force", opts.servers, {
        ltex = {
          -- see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ltex>
          -- NOTE: mason doesn't support ltex-ls-plus, which is better maintained
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
        marksman = {
          -- see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#marksman>
          filetypes = { "markdown", "quarto" }, -- extend to include quarto
        },
        texlab = {
          -- see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#texlab>
          settings = {
            texlab = {
              bibtexFormatter = "texlab",
              latexFormatter = "latexindent",
            },
          },
        },
        r_language_server = {
          -- see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#r_language_server>
          filetypes = { "r", "rmd", "quarto" }, -- extend to include quarto
          settings = {
            r = {
              lsp = {
                debug = false,
                diagnostics = true,
              },
            },
          },
        },
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
        julials = {
          -- see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#julials>
        },
      })
    end,
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- modify LSP servers
      opts.servers = vim.tbl_deep_extend("force", opts.servers, {
        ltex = {
          settings = {
            ltex = {
              checkFrequency = "save",
            },
          },
        },
        -- basedpyright = {
        --   settings = {
        --     basedpyright = {
        --       analysis = {
        --         autoSearchPaths = true,
        --         diagnosticMode = "openFilesOnly",
        --         useLibraryCodeForTypes = true
        --       },
        --     },
        --   },
        -- },
        pylsp = {
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
        r_language_server = {
          -- extend to include quarto
          filetypes = { "r", "rmd", "quarto" },
          settings = {
            r = {
              lsp = {
                debug = false,
                diagnostics = true,
              },
            },
          },
        },
        marksman = {
          -- extend to include quarto
          filetypes = { "markdown", "quarto" },
        },
      })
    end,
  },
}

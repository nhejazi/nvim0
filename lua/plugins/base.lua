-- every spec file under /plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {

  -- override nvim-cmp to add cmp-xxx sources
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-emoji',
      'ray-x/cmp-treesitter',
      'kdheepak/cmp-latex-symbols',
      'jmbuhr/cmp-pandoc-references',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'jmbuhr/otter.nvim',
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require 'cmp'

      opts.mapping = vim.tbl_extend('force', opts.mapping, {
        ['<Tab>'] = cmp.mapping(function(fallback)
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
        end, { 'i', 's', 'c' }),
        ['<CR>'] = cmp.mapping(function(fallback)
          cmp.abort()
          fallback()
        end, { 'i', 's', 'c' }),
      })
    end,
  },

  -- GitHub copilot
  {
    'zbirenbaum/copilot.lua',
    enabled = false,
    config = function()
      require('copilot').setup {
        panel = {
          enabled = true,
          auto_trigger = true,
          auto_refresh = true,
          keymap = {
            jump_prev = '[[',
            jump_next = ']]',
            accept = '<CR>',
            refresh = 'gr',
            open = '<M-CR>',
          },
          layout = {
            position = 'bottom', -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = false,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = '<M-l>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
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
          ['.'] = false,
        },
      }
    end,
  },

  -- add any tools you want to have installed below
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'stylua',
        'shellcheck',
        'shfmt',
        'flake8',
        'black',
      },
    },
  },
}

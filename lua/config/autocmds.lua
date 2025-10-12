-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional auto-commands here

-- from https://github.com/jmbuhr/quarto-nvim-kickstarter/blob/main/lua/config/autocommands.lua
local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = { "*" },
  command = "checktime",
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = { "*" },
  callback = function(_)
    vim.cmd.setlocal("nonumber", "norelativenumber")
    vim.wo.signcolumn = "no"
    -- set size of terminal
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd(":vert resize 70")
    end
    set_terminal_keymaps()
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "TermEnter" }, {
  pattern = { "*" },
  callback = function()
    -- set size of terminal
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd(":startinsert")
    end
  end,
})

-- LSP-specific keybindings and settings
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  desc = "LSP actions",
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

    -- Enable completion triggered by <c-x><c-o>
    if client and client:supports_method("textDocument/completion") then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end

    -- Enable inlay hints if supported (Neovim 0.10+)
    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Set up document highlighting
    if client and client:supports_method("textDocument/documentHighlight") then
      local highlight_augroup = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = highlight_augroup })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = bufnr,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- Optional: Buffer local keymaps (only add if not already set by LazyVim)
    -- Uncomment the ones you want to add/override
    local opts = { buffer = bufnr, silent = true }
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<leader>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    -- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- vim.keymap.set('n', '<leader>f', function()
    --   vim.lsp.buf.format { async = true }
    -- end, opts)
  end,
})

-- markdown-oxide custom commands and features
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("MarkdownOxideConfig", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Only run for markdown_oxide LSP
    if not client or client.name ~= "markdown_oxide" then
      return
    end

    local bufnr = ev.buf

    -- Daily Notes Commands
    -- :Daily [natural language date]
    -- Examples: :Daily, :Daily yesterday, :Daily next monday, :Daily 2024-01-15
    vim.api.nvim_create_user_command("Daily", function(args)
      local input = args.args
      client:exec_cmd({
        title = "Jump to daily note",
        command = "jump",
        arguments = { input },
      })
    end, { desc = "Open daily note with natural language date", nargs = "*" })

    -- :Today - Quick access to today's note
    vim.api.nvim_create_user_command("Today", function()
      client:exec_cmd({
        title = "Jump to today",
        command = "jump",
        arguments = { "today" },
      })
    end, { desc = "Open today's note" })

    -- :Yesterday - quick access to yesterday's note
    vim.api.nvim_create_user_command("Yesterday", function()
      client:exec_cmd({
        title = "Jump to yesterday",
        command = "jump",
        arguments = { "yesterday" },
      })
    end, { desc = "Open yesterday's note" })

    -- :Tomorrow - quick access to tomorrow's note
    vim.api.nvim_create_user_command("Tomorrow", function()
      client:exec_cmd({
        title = "Jump to tomorrow",
        command = "jump",
        arguments = { "tomorrow" },
      })
    end, { desc = "Open tomorrow's note" })

    -- Buffer-local Keymaps for Daily Notes
    local opts = { buffer = bufnr, silent = true }

    -- <leader>nt - Today's note
    vim.keymap.set("n", "<leader>nt", function()
      client:exec_cmd({
        title = "Jump to today",
        command = "jump",
        arguments = { "today" },
      })
    end, vim.tbl_extend("force", opts, { desc = "Open today's note" }))

    -- <leader>ny - Yesterday's note
    vim.keymap.set("n", "<leader>ny", function()
      client:exec_cmd({
        title = "Jump to yesterday",
        command = "jump",
        arguments = { "yesterday" },
      })
    end, vim.tbl_extend("force", opts, { desc = "Open yesterday's note" }))

    -- <leader>nm - Tomorrow's note
    vim.keymap.set("n", "<leader>nm", function()
      client:exec_cmd({
        title = "Jump to tomorrow",
        command = "jump",
        arguments = { "tomorrow" },
      })
    end, vim.tbl_extend("force", opts, { desc = "Open tomorrow's note" }))

    -- Code Lens Support (Reference Counts)
    local function check_codelens_support()
      local clients = vim.lsp.get_clients({ bufnr = bufnr })
      for _, c in ipairs(clients) do
        if c.server_capabilities.codeLensProvider then
          return true
        end
      end
      return false
    end

    -- Refresh code lens on various events
    vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "CursorHold", "BufEnter" }, {
      buffer = bufnr,
      group = vim.api.nvim_create_augroup("MarkdownOxideCodeLens", { clear = false }),
      callback = function()
        if check_codelens_support() then
          vim.lsp.codelens.refresh({ bufnr = bufnr })
        end
      end,
    })

    -- Initial code lens refresh
    vim.schedule(function()
      if check_codelens_support() then
        vim.lsp.codelens.refresh({ bufnr = bufnr })
      end
    end)
  end,
})

-- Additional PKM Keymaps (Available in all markdown files)
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("MarkdownPKMKeymaps", { clear = true }),
  pattern = "markdown",
  callback = function()
    local opts = { buffer = true, silent = true }

    -- <leader>nl - Create link from word under cursor
    vim.keymap.set("n", "<leader>nl", function()
      local word = vim.fn.expand("<cword>")
      if word and word ~= "" then
        vim.cmd("normal! ciw[[" .. word .. "]]")
        vim.cmd("normal! F[") -- Move cursor back into the link
      end
    end, vim.tbl_extend("force", opts, { desc = "Create wiki-link from word" }))

    -- <leader>nb - Show backlinks (references)
    vim.keymap.set(
      "n",
      "<leader>nb",
      vim.lsp.buf.references,
      vim.tbl_extend("force", opts, { desc = "Show backlinks" })
    )

    -- <leader>nv - Open link in vertical split
    vim.keymap.set("n", "<leader>nv", function()
      vim.cmd("vsplit")
      vim.lsp.buf.definition()
    end, vim.tbl_extend("force", opts, { desc = "Open link in split" }))

    -- <leader>np - Preview link without jumping
    vim.keymap.set("n", "<leader>np", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Preview link" }))
  end,
})

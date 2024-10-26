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
      vim.cmd ":vert resize 70"
    end
    set_terminal_keymaps()
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "TermEnter" }, {
  pattern = { "*" },
  callback = function()
    -- set size of terminal
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd ":startinsert"
    end
  end,
})

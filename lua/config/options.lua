-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- more opinionated
--vim.opt.number = true -- show linenumbers
vim.opt.relativenumber = false -- hide relative linenumbers
vim.opt.signcolumn = "number"
vim.opt.mousefocus = true
vim.opt.wildmenu = true
vim.opt.wildmode = "longest"

vim.opt.timeoutlen = 400 -- until which-key pops up
vim.opt.updatetime = 250 -- for autocommands and hovers

-- (don't == 0) replace certain elements with prettier ones
vim.opt.conceallevel = 0

-- don't ask about existing swap files
vim.opt.shortmess:append("A")

-- use less indentation
local tabsize = 2
vim.opt.shiftwidth = tabsize
vim.opt.tabstop = tabsize

-- smarter search
--vim.opt.ignorecase = true
--vim.opt.smartcase = true

-- indent
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- consistent number column
vim.opt.signcolumn = "yes:1"

-- how to show autocomplete menu
vim.opt.completeopt = "menuone,noinsert"

-- set marker for 80 columns
vim.opt.colorcolumn = "80"

vim.cmd [[
let g:currentmode={
       \ "n"      : "%#String# NORMAL ",
       \ "v"      : "%#Search# VISUAL ",
       \ "s"      : "%#ModeMsg# VISUAL ",
       \ "\<C-V>" : "%#Title# V·Block ",
       \ "V"      : "%#IncSearch# V·Line ",
       \ "Rv"     : "%#String# V·Replace ",
       \ "i"      : "%#ModeMsg# INSERT ",
       \ "R"      : "%#Substitute# R ",
       \ "c"      : "%#CurSearch# Command ",
       \ "t"      : "%#ModeMsg# TERM ",
       \}
]]

-- hide cmdline when not used
vim.opt.cmdheight = 1

-- split right and below by default
vim.opt.splitright = true
vim.opt.splitbelow = true

-- tabline
vim.opt.showtabline = 2

-- don't continue comments automagically
-- https://neovim.io/doc/user/options.html#'formatoptions'
vim.opt.formatoptions:remove "c"
vim.opt.formatoptions:remove "r"
vim.opt.formatoptions:remove "o"

-- scroll before end of window
vim.opt.scrolloff = 5


-- diagnostics
vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  signs = true,
}

-- add new filetypes
--vim.filetype.add {
--extension = {
--ojs = "javascript",
--},
--}

-- additional builtin vim packages
-- filter quickfix list with Cfilter
vim.cmd.packadd "cfilter"

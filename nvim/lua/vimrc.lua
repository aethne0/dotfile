--------------------------------------------------------------------------------
---- lua/vimcr.lua -------------------------------------------------------------
--------------------------------------------------------------------------------

vim.opt.number = true
vim.opt.relativenumber = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.showmode = false

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.signcolumn = 'yes'

vim.opt.cursorline = true

vim.opt.confirm = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.termguicolors = true

local hour = tonumber(os.date("%H"))
if hour >= 8 and hour < 20 then
    vim.opt.bg = 'light'
    vim.cmd.colorscheme 'morning'
else
    vim.opt.bg = 'dark'
    vim.cmd.colorscheme 'elflord'
end

vim.g.matchparen_disable_cursor_hl = 1

-- vim.opt.clipboard = "unnamed"

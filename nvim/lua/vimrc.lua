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

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.termguicolors = true

--[[
local hour = tonumber(os.date("%H"))
if hour >= 8 and hour < 20 then
    vim.opt.bg = 'light'
    vim.cmd.colorscheme 'catpuccin-latte' -- morning
else
    vim.opt.bg = 'dark'
    vim.cmd.colorscheme 'catpuccin-macchiato' -- elflord, murphy, evening
end
]]

vim.keymap.set('n', '<leader>ul', function()
    vim.opt.bg = 'light'
    vim.cmd.colorscheme 'catppuccin-latte'
end)
vim.keymap.set('n', '<leader>ud', function()
    vim.opt.bg = 'dark'
    vim.cmd.colorscheme 'catppuccin-macchiato'
end)

vim.g.matchparen_disable_cursor_hl = 1

-- vim.opt.clipboard = "unnamed"

vim.keymap.set('n', '<leader>cad', ':set autochdir<CR>', { silent = true })


vim.keymap.set('n', 'gh', ':lua vim.lsp.buf.hover()<CR>', { buffer = bufnr, desc = 'LSP hover' })
vim.keymap.set('n', 'gd', ':tab split | lua vim.lsp.buf.definition()<CR>', { buffer = bufnr, desc = 'Goto definition - new tab' })
--vim.keymap.set('n', 'gdd', ':lua vim.lsp.buf.definition()<CR>', { buffer = bufnr, desc = 'Goto definition - current' })
-- TODO:
-- vim.keymap.set('n', 'gdp', ':Lspsaga peek_definition<CR>', { buffer = bufnr, desc = 'Goto definition - peek' })
vim.keymap.set('n', 'gD', ':tab split | lua vim.lsp.buf.declaration()<CR>', { buffer = bufnr, desc = 'Goto definition - new tab' })
--vim.keymap.set('n', 'gDd', ':lua vim.lsp.buf.declaration()<CR>', { buffer = bufnr, desc = 'Goto definition - current' })
-- TODO:
-- vim.keymap.set('n', 'gDp', ':Lspsaga peek_definition<CR>', { buffer = bufnr, desc = 'Goto definition - peek' })

vim.keymap.set('n', '<leader>T', ':Telescope<CR>', { buffer = bufnr, desc = 'Telescope' })
vim.keymap.set('n', '<leader>F', ':Telescope find_files<CR>', { buffer = bufnr, desc = 'Telescope files' })

-- quarter page scrolling
vim.keymap.set('n', '<C-u>', function()
    local count = math.floor(vim.api.nvim_win_get_height(0) / 4)
    local curs = vim.api.nvim_win_get_cursor(0)
    local target_row = math.max(curs[1] - count, 1)

    -- sets both cursor-pos & window scroll
    vim.api.nvim_win_set_cursor(0, { target_row, curs[2] })
    vim.fn.winrestview({ topline = vim.fn.line('w0') - count, leftcol = 0 })
end, { desc = 'Scroll up 1/4 page' })

vim.keymap.set('n', '<C-f>', '<C-u>', { desc = 'Scroll up 1/4 page' })

vim.keymap.set('n', '<C-d>', function()
    local count = math.floor(vim.api.nvim_win_get_height(0) / 4)
    local curs = vim.api.nvim_win_get_cursor(0)
    local buff_line_count = vim.api.nvim_buf_line_count(0)
    local target_row = math.min(curs[1] + count, buff_line_count)

    -- sets both cursor-pos & window scroll
    vim.api.nvim_win_set_cursor(0, { target_row, curs[2] })
    vim.fn.winrestview({ topline = vim.fn.line('w0') + count, leftcol = 0 })
end, { desc = 'Scroll down 1/4 page' })

 

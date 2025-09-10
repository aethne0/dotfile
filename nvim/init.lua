--------------------------------------------------------------------------------
---- init.lua ------------------------------------------------------------------
--------------------------------------------------------------------------------

require('lua/vimrc')        -- basic options
require('lua/statusline')   -- statusline
require('lua/tabs')         -- tabs + tab binds

require('lua/lazy')         -- plugins

-- save
vim.keymap.set("n", '<C-s>', ":w<CR>", { silent = true })
-- lsp binds
vim.keymap.set("n", "K", "<Nop>", { buffer = bufnr })
vim.keymap.set("n", "gh", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP hover" })

------------------------
---- diagnostic stuff --
------------------------
vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = {
        current_line = true,
        highlight_whole_line = true,
    },
    signs = true,
    underline = true,
    --update_in_insert = true,
    severity_sort = true,
})
vim.keymap.set('n', '<C-l>', function()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })


-- diagnostic virtual line colors
function apply_diagnostic_virtual_line_hl()
    local diag_keys = {[1] = 'Error', [2] = 'Warn', [3] = 'Info', [4] = 'Hint', [5] = 'Ok'}

    for _, k in pairs(diag_keys) do
        local diag = vim.api.nvim_get_hl(0, { name = string.format('Diagnostic%s', k) })
        local diag_virt_line = vim.api.nvim_get_hl(0, { name = string.format('DiagnosticVirtualLines%s', k) })
        local foreground = diag_virt_line.fg or diag.fg
        vim.api.nvim_set_hl(0, string.format('DiagnosticVirtualLines%s', k), { fg = foreground, bg = '#202020'  })
    end
end

apply_diagnostic_virtual_line_hl()

vim.api.nvim_create_autocmd('ColorScheme', {
    callback = apply_diagnostic_virtual_line_hl,
})

------------------------
---- specific ----------
------------------------
vim.keymap.set('n', '<leader>rf', ':RustFmt<CR>', { silent = true })




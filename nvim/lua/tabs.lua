--------------------------------------------------------------------------------
---- lua/tabs.lua --------------------------------------------------------------
--------------------------------------------------------------------------------

vim.keymap.set("n", "<F11>", ":tabprevious<CR>", { silent = true })
vim.keymap.set("n", "<F12>", ":tabnext<CR>", { silent = true })
vim.keymap.set("n", "<C-F11>", ":tabmove -1<CR>", { silent = true })
vim.keymap.set("n", "<C-F12>", ":tabmove +1<CR>", { silent = true })

vim.keymap.set("n", "<leader>c", 
    function()
        local answer = vim.fn.input("Close current tab? (y/N): ")
        if answer:lower() == "y" then
            vim.cmd("tabclose")
        else
            print("Canceled")
        end
    end, 
    { silent = true, desc = 'close tab' }
)

vim.keymap.set("n", "<leader>t", 
    function()
        require("telescope.builtin").find_files({
        attach_mappings = function(_, map)
            map("i", "<CR>", function(prompt_bufnr)
                local selection = require("telescope.actions.state").get_selected_entry()
                require("telescope.actions").close(prompt_bufnr)
                vim.cmd("tabnew " .. selection.path)
            end)
            return true
        end,
        })
    end, { desc = 'open file' }
)

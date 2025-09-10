--------------------------------------------------------------------------------
---- lua/lazy.lua --------------------------------------------------------------
--------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo(
            {
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out, "WarningMsg" },
                { "\nPress any key to exit..." },
            }, 
            true, {}
        )
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {

        -- lsp
        { 
            'mason-org/mason-lspconfig.nvim',

            dependencies = {
                'neovim/nvim-lspconfig',
                'mason-org/mason.nvim',
            },

            config = function()
                require('mason').setup()
                require('mason-lspconfig').setup()

            end
        },

        {
            "hrsh7th/nvim-cmp",
            -- autocompletion
            dependencies = {
              "hrsh7th/cmp-nvim-lsp",
              "L3MON4D3/LuaSnip",
              "saadparwaiz1/cmp_luasnip",
            },
            config = function()
              local cmp = require("cmp")
              cmp.setup({

                snippet = {
                  expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                  end,
                },

                mapping = cmp.mapping.preset.insert({
                  ["<C-Space>"] = cmp.mapping.complete(),
                  ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),

                sources = cmp.config.sources({
                  { name = "nvim_lsp" },
                  { name = "luasnip" },
                }),

                formatting = {
                    fields = { "abbr", "menu", "kind" },
                    format = function(entry, item)
                        -- Define menu shorthand for different completion sources.
                        local menu_icon = {
                            nvim_lsp = "LSP",
                            nvim_lua = "LUA",
                            luasnip  = "SNP",
                            buffer   = "BUF",
                            path     = "PWD",
                        }
                        -- Set the menu "icon" to the shorthand for each completion source.
                        item.menu = menu_icon[entry.source.name]

                        -- Set the fixed width of the completion menu to 60 characters.
                        -- fixed_width = 20

                        -- Set 'fixed_width' to false if not provided.
                        fixed_width = fixed_width or false

                        -- Get the completion entry text shown in the completion window.
                        local content = item.abbr

                        -- Set the fixed completion window width.
                        if fixed_width then
                            vim.o.pumwidth = fixed_width
                        end

                        -- Get the width of the current window.
                        local win_width = vim.api.nvim_win_get_width(0)

                        -- Set the max content width based on either: 'fixed_width'
                        -- or a percentage of the window width, in this case 20%.
                        -- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
                        local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

                        -- Truncate the completion entry text if it's longer than the
                        -- max content width. We subtract 3 from the max content width
                        -- to account for the "..." that will be appended to it.
                        if #content > max_content_width then
                            item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
                        else
                            item.abbr = content .. (" "):rep(max_content_width - #content)
                        end
                        return item
                    end,
                },

              })
            end,
          },

        {
          -- file explorer etc
          'nvim-telescope/telescope.nvim',
          dependencies = { "nvim-lua/plenary.nvim" },
            --cmd = { "Telescope" },
            config = function() 
                require('telescope').setup{
                    defaults = {
                        file_ignore_patterns = {},
                        find_command = { 'rg', '--files', '--ignore', '--hidden' },
                    },
                    pickers = { 
                        colorscheme = {
                            enable_preview = true
                        },
                    },
                }
            end,
        },


        {
            'lewis6991/gitsigns.nvim',
            -- this is various git integration, including the left-side symbols
            opts = {
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                }
            }
        },

        -- lsp bottom-right notifs
        { 
            'j-hui/fidget.nvim',
            opts = {},
        },

        { 
            'unblevable/quick-scope',
        },

        {
            'chentoast/marks.nvim',
            config = function() 
                require('marks').setup()
            end
        },

        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            opts = {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            },
            keys = {
                {
                    "<leader>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "Buffer Local Keymaps (which-key)",
                },
            },
        }


    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { 'koehler' } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})


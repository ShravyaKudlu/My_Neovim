return {

    -- test new blink
    { import = "nvchad.blink.lazyspec" },

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.treesitter")
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require("configs.mason-lspconfig")
        end,
    },
    {
        "kawre/leetcode.nvim",
        -- If you are using a local clone, use 'dir'.
        -- If you want the latest from GitHub, remove 'dir' and use 'branch'.
        -- dir = vim.fn.stdpath("data") .. "/lazy/leetcode.nvim",
        branch = "master",
        lazy = false,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        config = function(_, opts)
            require("leetcode").setup(opts)
        end,
        opts = {
            arg = "leetcode.com",
            lang = "python3",
            image_support = true,
            storage = {
                home = "/home/shravyashanbhogue/leetcode",
                cache = vim.fn.stdpath("cache") .. "/leetcode",
            },
        },
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.lint")
        end,
    },

    {
        "rshkarin/mason-nvim-lint",
        event = "VeryLazy",
        dependencies = { "nvim-lint" },
        config = function()
            require("configs.mason-lint")
        end,
    },

    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("configs.conform")
        end,
    },

    {
        "zapling/mason-conform.nvim",
        event = "VeryLazy",
        dependencies = { "conform.nvim" },
        config = function()
            require("configs.mason-conform")
        end,
    },
    {
        "kylechui/nvim-surround",
        version = "^3.0.0",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        opts = {
            filters = {
                dotfiles = true,
                custom = { "*.class" },
                exclude = { ".env" },
            },
        },
    },
    {
        "github/copilot.vim",
        event = "InsertEnter",
        cmd = {
            "Copilot",
            "CopilotEnable",
            "CopilotDisable",
            "CopilotPanel",
            "CopilotStatus",
        },
        config = function()
            vim.g.copilot_no_tab_map = true
        end,
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
    },
    {
        "elmcgill/springboot-nvim",
        ft = { "java" },
        dependencies = {
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-jdtls",
        },
        config = function()
            require("springboot-nvim").setup({})
        end,
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        config = function()
            require("dressing").setup({
                input = {
                    enabled = true,
                    border = "rounded",
                    relative = "editor",
                    anchor = "NW",
                    prefer_width = 50,
                    win_options = { winblend = 10 },
                },
                select = {
                    enabled = true,
                    backend = { "telescope", "builtin" },
                    builtin = {
                        border = "rounded",
                        relative = "editor",
                        anchor = "NW",
                        width = 50,
                        height = 10,
                    },
                },
            })
        end,
    },

    {
        "alessio-vivaldelli/java-creator-nvim",
        ft = { "java" },
        event = "VeryLazy",
        dependencies = {
            { "nvim-telescope/telescope.nvim", optional = true },
            { "stevearc/dressing.nvim" },
        },
        config = function()
            require("java-creator-nvim").setup({
                options = {
                    java_version = 21,
                    auto_open = true,
                    use_notify = false,
                    custom_src_path = "backend/src/main/java",
                    src_patterns = { "src/main/java", "src/test/java", "src" },
                    project_markers = {
                        "pom.xml",
                        "build.gradle",
                        "settings.gradle",
                        ".project",
                        "backend",
                    },
                    package_selection_style = "hybrid",
                    notification_timeout = 3000,
                },
                keymaps = {},
                default_imports = {
                    record = { "java.util.*" },
                },
            })
        end,
    },
    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
    },
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
    },
    {
        "3rd/image.nvim",
        lazy = true,
        opts = function()
            require("image").setup({
                backend = "kitty", -- or "ueberzug"
                integrations = {
                    markdown = {
                        enabled = true,
                        clear_in_insert_mode = true,
                        filetypes = { "markdown", "md", "mdx" },
                        only_render_image_at_cursor = true,
                        download_remote_images = true,
                    },
                    -- you can add more integrations if needed
                },
            })
        end,
    },
}

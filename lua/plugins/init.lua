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
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        cmd = { "Leet" },
        opts = {
            lang = "python",
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
            { "stevearc/dressing.nvim" }, -- connect ui.select
        },
        config = function()
            require("java-creator-nvim").setup({
                options = {
                    java_version = 21,
                    auto_open = true,
                    use_notify = false, -- you can enable if you want
                    custom_src_path = "backend/src/main/java",
                    src_patterns = { "src/main/java", "src/test/java", "src" },
                    project_markers = {
                        "pom.xml",
                        "build.gradle",
                        "settings.gradle",
                        ".project",
                        "backend",
                    },
                    package_selection_style = "hybrid", -- auto/menu/hybrid
                    notification_timeout = 3000,
                },
                keymaps = {}, -- disable plugin defaults
                default_imports = {
                    record = { "java.util.*" },
                },
            })
        end,
    },
}

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
}

-- ~/.config/nvim/lua/configs/conform.lua

local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        javascriptreact = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        java = { "google-java-format" },
    },

    formatters = {
        black = {
            command = "/home/shravyashanbhogue/.venvs/nvim-formatters/bin/black",
            prepend_args = { "--fast", "--line-length", "80" },
        },
        isort = {
            command = "/home/shravyashanbhogue/.venvs/nvim-formatters/bin/isort",
            prepend_args = { "--profile", "black" },
        },
        stylua = {
            command = "/home/shravyashanbhogue/.local/share/nvim/mason/bin/stylua",
            prepend_args = {
                "--column-width",
                "80",
                "--line-endings",
                "Unix",
                "--indent-type",
                "Spaces",
                "--indent-width",
                "4",
            },
        },
        prettierd = {
            command = "/home/shravyashanbhogue/.local/share/nvim/mason/bin/prettierd",
        },
        google_java_format = {
            command = "/home/shravyashanbhogue/.local/share/nvim/mason/bin/google-java-format",
        },
    },

    format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
    },
}

require("conform").setup(options)

-- Async formatting after write
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    callback = function(args)
        -- async call, will not block or crash on errors
        require("conform").format({ bufnr = args.buf, async = true })
    end,
})

local lint = require("lint")

lint.linters_by_ft = {
    lua = { "luacheck" },
    -- haskell = { "hlint" },
    python = { "flake8" },
    java = { "checkstyle" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
}

lint.linters.luacheck.args = {
    "--globals",
    "love",
    "vim",
    "--formatter",
    "plain",
    "--codes",
    "--ranges",
    "-",
}
-- -- Set the path to your checkstyle.xml file as a global variable
vim.g.checkstyle_config = vim.fn.expand("$HOME")
    .. "/.config/nvim/checkstyle.xml"

-- Define the checkstyle linter
lint.linters.checkstyle.args = {
    "-c",
    vim.g.checkstyle_config, -- path to config
    "-", -- read from stdin
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        lint.try_lint()
    end,
})

local options = {
    ensure_installed = {
        "bash",
        -- "c",
        -- "cmake",
        -- "cpp",
        "fish",
        -- "go",
        -- "gomod",
        -- "gosum",
        -- "gotmpl",
        -- "gowork",
        -- "haskell",
        "lua",
        "luadoc",
        -- "make",
        "markdown",
        -- "odin",
        "printf",
        "python",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
        "java",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "html",
        "css",
        "scss",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)

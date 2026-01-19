-- ~/.config/nvim/lua/configs/mason-lspconfig.lua

local mason_lspconfig = require("mason-lspconfig")

-- List of LSP servers you want Mason to ensure installed
local servers = {
    "pyright",
    "ts_ls",
    "html",
    "tailwindcss",
    "jsonls",
    "cssls",
    "lua_ls",
}

-- Optional: ignore servers you don't want Mason to install
local ignore_install = {
    -- example: "tsserver"
}

-- Filter servers to exclude ignored ones
local ensure_installed = {}
for _, server in ipairs(servers) do
    local skip = false
    for _, ignore in ipairs(ignore_install) do
        if server == ignore then
            skip = true
            break
        end
    end
    if not skip then
        table.insert(ensure_installed, server)
    end
end

-- Setup Mason-LSP
mason_lspconfig.setup({
    ensure_installed = ensure_installed,
    automatic_installation = true, -- install on demand if not present
})

-- ~/.config/nvim/lua/configs/lspconfig.lua

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- List of servers to configure
local servers = { "pyright", "ts_ls", "html", "lua_ls" }

for _, name in ipairs(servers) do
    local ok, server =
        pcall(require, "lspconfig.server_configurations." .. name)
    if ok and server then
        require("lspconfig")[name].setup({
            on_attach = on_attach,
            on_init = on_init,
            capabilities = capabilities,
        })
    else
        vim.notify("[LSP] server not found: " .. name, vim.log.levels.WARN)
    end
end

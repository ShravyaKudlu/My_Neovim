local jdtls = require("jdtls")
local home = os.getenv("HOME")

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if not root_dir then
    return
end

local workspace_dir = home
    .. "/.local/share/eclipse/"
    .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.glob(
            home
                .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
        ),
        "-configuration",
        home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
        "-data",
        workspace_dir,
    },
    root_dir = root_dir,
    capabilities = require("nvchad.configs.lspconfig").capabilities,
    on_init = require("nvchad.configs.lspconfig").on_init,
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        if client.server_capabilities.semanticTokensProvider then
            vim.lsp.semantic_tokens.start(bufnr)
        end
        require("nvchad.configs.lspconfig").on_attach(client, bufnr)
    end,
}

jdtls.start_or_attach(config)

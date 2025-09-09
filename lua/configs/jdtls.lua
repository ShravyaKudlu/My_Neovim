local jdtls = require("jdtls")
local home = os.getenv("HOME")
local java_home = os.getenv("JAVA_HOME")
local mason_registry = require("mason-registry")

-- ===== Helper functions =====
local function get_jdtls()
    local jdtls_pkg = mason_registry.get_package("jdtls")
    local jdtls_path = jdtls_pkg:get_install_path()
    local launcher =
        vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
    local lombok = jdtls_path .. "/lombok.jar"
    local system = "linux" -- change to "mac" or "win" if needed
    local config = jdtls_path .. "/config_" .. system
    return launcher, config, lombok
end

local function get_workspace()
    local workspace_base = home .. "/code/workspace/"
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = workspace_base .. project_name
    vim.fn.mkdir(workspace_dir, "p")
    return workspace_dir
end

-- ===== Main setup =====
local function setup_jdtls()
    local launcher, os_config, lombok = get_jdtls()
    local workspace_dir = get_workspace()
    local root_dir = jdtls.setup.find_root({
        ".git",
        "mvnw",
        "gradlew",
        "pom.xml",
        "build.gradle",
    })
    if not root_dir then
        return
    end

    -- JDTLS capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    -- JDTLS command
    local cmd = {
        java_home .. "/bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:" .. lombok,
        "-jar",
        launcher,
        "-configuration",
        os_config,
        "-data",
        workspace_dir,
    }

    -- JDTLS settings
    local settings = {
        java = {
            eclipse = { downloadSources = true },
            maven = { downloadSources = true },
            lombok = { lombokAgent = lombok },
            format = { enabled = true },
            saveActions = { organizeImports = true },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
                importOrder = { "java", "jakarta", "javax", "com", "org" },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticThreshold = 9999,
                },
            },
            inlayHints = { parameterNames = { enabled = "all" } },
            referencesCodeLens = { enabled = true },
            configuration = { updateBuildConfiguration = "interactive" },
        },
    }

    local init_options = {
        bundles = {},
        extendedClientCapabilities = extendedClientCapabilities,
    }

    -- On attach
    local function on_attach()
        pcall(require, "nvchad.mappings") -- load mappings
        require("jdtls.setup").add_commands()

        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.java" },
            callback = function()
                pcall(vim.lsp.codelens.refresh)
            end,
        })
    end

    -- Start or attach JDTLS
    jdtls.start_or_attach({
        cmd = cmd,
        root_dir = root_dir,
        settings = settings,
        capabilities = capabilities,
        init_options = init_options,
        on_attach = on_attach,
    })
end

return { setup_jdtls = setup_jdtls }

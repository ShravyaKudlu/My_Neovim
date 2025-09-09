require("nvchad.mappings")

local map = vim.keymap.set

-- Command mode
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Fast escape from insert mode
map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- Quit all
map("n", "ZZ", "<cmd>qa<CR>", { desc = "Quit Neovim" })

-- Undo / Redo
map("n", "<C-z>", "u", { desc = "Undo (normal)" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo (insert)" })
map("n", "<C-y>", "<C-r>", { desc = "Redo (normal)" })
map("i", "<C-y>", "<C-o><C-r>", { desc = "Redo (insert)" })

-- Select All
map("n", "<C-a>", "ggVG", { desc = "Select All (normal)" })
map("i", "<C-a>", "<ESC>ggVG", { desc = "Select All (insert)" })

-- Save file
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- Copy to clipboard (Visual mode) with Ctrl+Shift+C
map("v", "<C-S-c>", '"+y', { desc = "Copy to clipboard (Visual)" })

-- Paste from clipboard with Ctrl+Shift+V
map("n", "<C-S-v>", '"+p', { desc = "Paste from clipboard (Normal)" })
map("i", "<C-S-v>", "<C-r>+", { desc = "Paste from clipboard (Insert)" })
map("v", "<C-S-v>", '"+p', { desc = "Paste from clipboard (Visual)" })

-- LeetCode.nvim keymaps
map("n", "<leader>ll", ":Leet lang<CR>", { desc = "Set LeetCode language" })
map("n", "<leader>lt", ":Leet test<CR>", { desc = "Run LeetCode test" })
map("n", "<leader>lc", ":Leet console<CR>", { desc = "Open LeetCode console" })
map("n", "<leader>lh", ":Leet hint<CR>", { desc = "Show LeetCode hint" })
map("n", "<leader>ls", ":Leet submit<CR>", { desc = "Submit to LeetCode" })

-- Accept full suggestion
map("i", "<A-a>", 'copilot#Accept("<CR>")', {
    expr = true,
    silent = true,
    replace_keycodes = false,
    desc = "Accept Copilot Suggestion",
})

-- Accept one line only
map("i", "<A-l>", "<Plug>(copilot-accept-line)", {
    replace_keycodes = false,
    desc = "Accept Copilot Suggestion line",
})
-- Accept one word only
map("i", "<A-w>", "<Plug>(copilot-accept-word)", {
    replace_keycodes = false,
    desc = "Accept Copilot Suggestion word",
})

-- Navigate suggestions
map("i", "<A-n>", "<Plug>(copilot-next)", { desc = "Next Copilot Suggestion" })
map(
    "i",
    "<A-p>",
    "<Plug>(copilot-previous)",
    { desc = "Previous Copilot Suggestion" }
)

-- Dismiss suggestion
map(
    "i",
    "<A-d>",
    "<Plug>(copilot-dismiss)",
    { desc = "Dismiss Copilot Suggestion" }
)
local ok, springboot = pcall(require, "springboot-nvim")
if ok then
    map(
        "n",
        "<leader>Jr",
        springboot.boot_run,
        { desc = "[J]ava [R]un Spring Boot" }
    )
    map(
        "n",
        "<leader>Jc",
        springboot.generate_class,
        { desc = "[J]ava Create [C]lass" }
    )
    map(
        "n",
        "<leader>Ji",
        springboot.generate_interface,
        { desc = "[J]ava Create [I]nterface" }
    )
    map(
        "n",
        "<leader>Je",
        springboot.generate_enum,
        { desc = "[J]ava Create [E]num" }
    )
end

-- ===== Java / JDTLS mappings =====
map(
    "n",
    "<leader>Jo",
    "<Cmd>lua require('jdtls').organize_imports()<CR>",
    { desc = "[J] Organize [O] Imports" }
)
map(
    "n",
    "<leader>Jv",
    "<Cmd>lua require('jdtls').extract_variable()<CR>",
    { desc = "[J] Extract [V]ariable" }
)
map(
    "v",
    "<leader>Jv",
    "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
    { desc = "[J] Extract [V]ariable (visual)" }
)
map(
    "n",
    "<leader>JC",
    "<Cmd>lua require('jdtls').extract_constant()<CR>",
    { desc = "[J] Extract [C]onstant" }
)
map(
    "v",
    "<leader>JC",
    "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
    { desc = "[J] Extract [C]onstant (visual)" }
)
map(
    "n",
    "<leader>Jt",
    "<Cmd>lua require('jdtls').test_nearest_method()<CR>",
    { desc = "[J] Test Method" }
)
map(
    "v",
    "<leader>Jt",
    "<Esc><Cmd>lua require('jdtls').test_nearest_method(true)<CR>",
    { desc = "[J] Test Method (visual)" }
)
map(
    "n",
    "<leader>JT",
    "<Cmd>lua require('jdtls').test_class()<CR>",
    { desc = "[J] Test Class" }
)
map(
    "n",
    "<leader>Ju",
    "<Cmd>lua require('jdtls').update_project_config()<CR>",
    { desc = "[J] Update Config" }
)

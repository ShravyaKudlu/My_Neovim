require("nvchad.mappings")

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
-- Safely unmap default terminal keys
pcall(vim.keymap.del, "n", "<Space>h")
pcall(vim.keymap.del, "n", "<Space>v")
pcall(vim.keymap.del, "t", "<Space>h")
pcall(vim.keymap.del, "t", "<Space>v")

-- Next/prev buffer without tabufline
map("n", "<TAB>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-TAB>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>x", "<cmd>bd<CR>", { desc = "Close buffer" })

map("n", "<leader>u", ":UndotreeToggle<CR>", opts)
-- Quit al

map(
    "i",
    "jk",
    "<ESC>",
    { desc = "Escape insert mode", noremap = true, silent = true }
)
map(
    "i",
    "jj",
    "<ESC>",
    { desc = "Escape insert mode", noremap = true, silent = true }
)

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

-- Map <leader>ca to trigger LSP code actions
map("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
end, { desc = "LSP Code Actions", noremap = true, silent = true })

map("v", "<leader>ca", function()
    vim.lsp.buf.code_action()
end, { desc = "LSP Code Actions (visual)", noremap = true, silent = true })
-- Map convert Objects to JSON in visual mode
map(
    "v", -- visual mode
    "<A-j>", -- Alt+j
    function()
        -- Get start and end line of visual selection
        local start_line = vim.fn.line("'<")
        local end_line = vim.fn.line("'>")
        vim.cmd(start_line .. "," .. end_line .. "AssignmentsToJSON")
    end,
    { desc = "Convert selected assignments to JSON" }
)
-- ===== Java / JDTLS mappings =====
local ok_spring, springboot = pcall(require, "springboot-nvim")
if ok_spring then
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

vim.keymap.set("n", "<leader>Jn", "<cmd>JavaNew<CR>", { desc = "[J]ava [N]ew" })

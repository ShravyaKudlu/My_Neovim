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

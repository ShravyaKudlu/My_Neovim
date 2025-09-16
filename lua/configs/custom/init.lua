-- ~/.config/nvim/lua/custom/init.lua
local M = {}

M.setup = function()
    -- === Diagnostics ===
    vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        severity_sort = true,
        float = { border = "rounded", source = true },
    })

    vim.fn.sign_define(
        "DiagnosticSignError",
        { text = "✗", texthl = "DiagnosticError" }
    )
    vim.fn.sign_define(
        "DiagnosticSignWarn",
        { text = "⚠", texthl = "DiagnosticWarn" }
    )
    vim.fn.sign_define(
        "DiagnosticSignInfo",
        { text = "ℹ", texthl = "DiagnosticInfo" }
    )
    vim.fn.sign_define(
        "DiagnosticSignHint",
        { text = "➤", texthl = "DiagnosticHint" }
    )

    vim.o.updatetime = 250
    vim.cmd(
        [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focus = false })]]
    )

    -- === Highlight yank ===
    vim.api.nvim_create_autocmd("TextYankPost", {
        desc = "Highlight when yanking (copying) text",
        group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
        callback = function()
            vim.hl.on_yank()
        end,
    })

    -- === Auto close tree after opening a file ===
    vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
            local api = require("nvim-tree.api")
            -- If the buffer is not NvimTree itself, close NvimTree
            if vim.bo.filetype ~= "NvimTree" and api.tree.is_visible() then
                api.tree.close()
            end
        end,
    })
    vim.api.nvim_create_user_command("AssignmentsToJSON", function(opts)
        local lines =
            vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
        local json_lines = { "{" }

        for _, line in ipairs(lines) do
            local key = line:match("%w+%.(%w+)%s*=") -- matches this. or self.
            if key then
                table.insert(
                    json_lines,
                    string.format('  "%s": "%s",', key, key)
                )
            end
        end

        if #json_lines > 1 then
            json_lines[#json_lines] = json_lines[#json_lines]:gsub(",$", "") -- remove trailing comma
        end
        table.insert(json_lines, "}")

        -- Open a new scratch buffer
        vim.cmd("enew") -- creates a new buffer
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, json_lines)

        -- Make it scratch/unlisted
        vim.bo[buf].buftype = "nofile"
        vim.bo[buf].bufhidden = "wipe"
        vim.bo[buf].modifiable = true

        -- Copy all lines to clipboard
        vim.cmd('normal! ggVG"+y')
        print(
            "JSON generated and copied to clipboard! Use :q to close this buffer."
        )
    end, { range = true })
end
-- Run setup immediately
M.setup()

return M

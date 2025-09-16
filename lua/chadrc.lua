-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(
require("configs.custom.init")
---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "ayu_dark",

    -- hl_override = {
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
    -- },
    hl_override = {
        Visual = { bg = "#555555", fg = "#FFFFFF", bold = true }, -- make selection clear
    },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
    tabufline = {
        enabled = false,
    },
}

return M

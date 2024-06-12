
local daps = require "mason.daps"
local formatters = require "mason.formatters"
local linters = require "mason.linters"
local lsps = require "mason.lsps"

local function tableMerge(t1, t2, t3, t4, result)
	for _, v in ipairs(t1) do
		table.insert(result, v)
	end
	for _, v in ipairs(t2) do
		table.insert(result, v)
	end
    for _, v in ipairs(t3) do
		table.insert(result, v)
	end
    for _, v in ipairs(t4) do
		table.insert(result, v)
	end
end

local mason_installation_list = {}

tableMerge(daps, formatters, linters, lsps, mason_installation_list)

return {
    ui = { border = "rounded" },
    ensure_installed = mason_installation_list,
    log_level = vim.log.levels.DEBUG,
}

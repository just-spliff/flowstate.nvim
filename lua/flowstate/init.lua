local M = {}

local utils = require("flowstate.utils")
local config = require("flowstate.config")

-- Funkcja do włączania/wyłączania trybu flowstate
M.toggle = function()
	if config.is_active then
		utils.disable_centering()
		config.is_active = false
	else
		utils.enable_centering()
		config.is_active = true
	end
end

-- Rejestracja komendy Neovim
M.setup = function()
	vim.api.nvim_create_user_command("FlowstateToggle", function()
		M.toggle()
	end, { desc = "Toggle Flowstate mode" })
end

return M

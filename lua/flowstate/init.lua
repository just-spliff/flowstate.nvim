local M = {}

local utils = require("flowstate.utils")
local config = require("flowstate.config")

-- Funkcja do włączania/wyłączania trybu flowstate
M.toggle = function()
	if config.is_active then
		utils.close_window()
		utils.restore_ui()
		config.is_active = false
	else
		utils.center_window()
		utils.hide_ui()
		config.is_active = true
	end
end

-- Rejestracja komendy Neovim
M.setup = function()
	vim.api.nvim_create_user_command(
		"FlowstateToggle", -- Nazwa komendy
		function()
			M.toggle()
		end, -- Wywołanie funkcji toggle
		{ desc = "Toggle Flowstate mode" } -- Opis komendy
	)
end

return M

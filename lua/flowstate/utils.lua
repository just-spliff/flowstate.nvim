local M = {}
local config = require("flowstate.config")

-- Włącz centrowanie w poziomie
M.enable_centering = function()
	local win_width = vim.api.nvim_get_option("columns") -- Szerokość ekranu
	local text_width = config.settings.text_width

	-- Oblicz marginesy po obu stronach
	local side_margin = math.max(0, math.floor((win_width - text_width) / 2))

	-- Ustaw marginesy i wyśrodkowanie
	vim.api.nvim_win_set_option(0, "wrap", false) -- Wyłącz zawijanie linii
	vim.api.nvim_win_set_option(0, "winhighlight", "Normal:Normal") -- Styl okna
	vim.api.nvim_buf_set_option(0, "textwidth", text_width) -- Ustaw szerokość tekstu
	vim.api.nvim_win_set_option(0, "sidescrolloff", side_margin) -- Marginesy boczne
end

-- Wyłącz centrowanie
M.disable_centering = function()
	vim.api.nvim_win_set_option(0, "sidescrolloff", 0) -- Przywróć marginesy
	vim.api.nvim_win_set_option(0, "wrap", true) -- Przywróć zawijanie linii
	vim.api.nvim_buf_set_option(0, "textwidth", 0) -- Wyłącz ograniczenie szerokości
end

return M

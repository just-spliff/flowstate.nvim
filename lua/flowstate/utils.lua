local M = {}
local config = require("flowstate.config")

-- Funkcja obliczająca marginesy i centrowanie
M.enable_centering = function()
	local win_width = vim.api.nvim_get_option("columns") -- Szerokość ekranu
	local text_width = config.settings.text_width

	if text_width >= win_width then
		vim.notify("Flowstate: text width exceeds window width!", vim.log.levels.WARN)
		return
	end

	-- Oblicz marginesy po obu stronach
	local side_padding = math.floor((win_width - text_width) / 2)

	-- Ustawienia centrowania
	vim.opt.wrap = false -- Wyłącz zawijanie linii
	vim.opt.colorcolumn = tostring(text_width + 1) -- Linia pomocnicza do wyrównania
	vim.opt.scrolloff = 0 -- Wyzeruj margines pionowy
	vim.opt.sidescrolloff = 0 -- Wyzeruj przesuwanie w poziomie

	-- Ustawienia bocznych marginesów
	vim.api.nvim_win_set_option(0, "winhighlight", "Normal:Normal")
	vim.api.nvim_win_set_option(0, "foldcolumn", "0") -- Wyłącz kolumnę składania
	vim.api.nvim_win_set_option(0, "signcolumn", "no") -- Ukryj kolumnę znaków
	vim.api.nvim_win_set_option(0, "statuscolumn", string.rep(" ", side_padding))
end

-- Funkcja przywracająca domyślne ustawienia
M.disable_centering = function()
	vim.opt.wrap = true -- Przywróć zawijanie linii
	vim.opt.colorcolumn = "" -- Usuń linię pomocniczą
	vim.opt.sidescrolloff = 0 -- Przywróć domyślny margines
	vim.opt.scrolloff = 8 -- Przywróć domyślne marginesy pionowe

	-- Przywrócenie domyślnej kolumny
	vim.api.nvim_win_set_option(0, "foldcolumn", "1")
	vim.api.nvim_win_set_option(0, "signcolumn", "yes")
	vim.api.nvim_win_set_option(0, "statuscolumn", "")
end

return M

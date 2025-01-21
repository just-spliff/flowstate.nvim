local M = {}
local config = require("flowstate.config")

-- Oblicz i zastosuj centrowanie poziome
M.enable_centering = function()
	local win_width = vim.api.nvim_get_option("columns") -- Szerokość okna
	local text_width = config.settings.text_width

	if text_width >= win_width then
		vim.notify("Flowstate: text width exceeds window width!", vim.log.levels.WARN)
		return
	end

	-- Oblicz marginesy
	local side_padding = math.floor((win_width - text_width) / 2)

	-- Manipulacja 'win_options' dla efektu wyśrodkowania
	vim.opt.wrap = false -- Wyłącz zawijanie linii
	vim.opt.scrolloff = 0 -- Wyzeruj margines pionowy
	vim.opt.sidescrolloff = 0 -- Wyzeruj przesuwanie w poziomie
	vim.api.nvim_win_set_option(0, "winhighlight", "Normal:Normal") -- Bez specjalnego stylu
	vim.cmd(string.format("setlocal leftmargin=%d rightmargin=%d", side_padding, side_padding)) -- Marginesy

	-- Ukryj zbędne elementy interfejsu
	vim.api.nvim_win_set_option(0, "foldcolumn", "0") -- Wyłącz kolumnę składania
	vim.api.nvim_win_set_option(0, "signcolumn", "no") -- Ukryj kolumnę znaków
end

-- Przywróć domyślne ustawienia
M.disable_centering = function()
	vim.opt.wrap = true -- Przywróć zawijanie linii
	vim.opt.scrolloff = 8 -- Przywróć domyślny margines pionowy
	vim.opt.sidescrolloff = 8 -- Przywróć domyślny margines poziomy
	vim.cmd("setlocal leftmargin=0 rightmargin=0") -- Usuń marginesy

	-- Przywróć domyślny interfejs
	vim.api.nvim_win_set_option(0, "foldcolumn", "1")
	vim.api.nvim_win_set_option(0, "signcolumn", "yes")
end

return M

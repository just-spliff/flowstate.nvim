local M = {}
local config = require("flowstate.config")

-- Włącz centrowanie poziome
M.enable_centering = function()
	local win_width = vim.api.nvim_get_option("columns") -- Szerokość okna
	local text_width = config.settings.text_width

	-- Oblicz marginesy boczne
	local side_margin = math.max(0, math.floor((win_width - text_width) / 2))

	-- Ustaw centrowanie
	vim.opt.wrap = false -- Wyłącz zawijanie linii
	vim.opt.colorcolumn = tostring(text_width + 1) -- Pokaż linię ograniczającą
	vim.opt.scrolloff = 0 -- Wyzeruj margines w pionie
	vim.opt.sidescrolloff = side_margin -- Ustaw margines w poziomie
end

-- Wyłącz centrowanie
M.disable_centering = function()
	vim.opt.wrap = true -- Przywróć zawijanie linii
	vim.opt.colorcolumn = "" -- Usuń linię ograniczającą
	vim.opt.sidescrolloff = 0 -- Przywróć domyślny margines
end

return M

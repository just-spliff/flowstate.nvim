local M = {}

local config = require("flowstate.config")

local win_id = nil
local buf_id = nil

-- Tworzenie wyśrodkowanego okna
M.center_window = function()
	local ui = vim.api.nvim_list_uis()[1]
	local win_width = config.settings.window_width
	local win_height = config.settings.window_height
	local col = math.floor((ui.width - win_width) / 2)
	local row = math.floor((ui.height - win_height) / 2)

	-- Utwórz tymczasowy bufor
	buf_id = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_option(buf_id, "bufhidden", "wipe")

	-- Otwórz okno pływające
	win_id = vim.api.nvim_open_win(buf_id, true, {
		relative = "editor",
		width = win_width,
		height = win_height,
		col = col,
		row = row,
		style = "minimal",
		border = config.settings.border,
	})

	-- Dodaj przykładowy tekst
	vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, {
		"🧘 Focus Mode ",
	})
end

-- Zamknij okno
M.close_window = function()
	if win_id and vim.api.nvim_win_is_valid(win_id) then
		vim.api.nvim_win_close(win_id, true)
	end
	win_id = nil
	buf_id = nil
end

-- Ukryj interfejs
M.hide_ui = function()
	if config.settings.hide_statusline then
		vim.opt.laststatus = 0
	end
	if config.settings.hide_tabline then
		vim.opt.showtabline = 0
	end
end

-- Przywróć interfejs
M.restore_ui = function()
	vim.opt.laststatus = 3
	vim.opt.showtabline = 2
end

return M

local lib = require("diffview.lib")
local diffview = require("diffview")

local M = {}

function M.smart_quit()
	local bufnr = vim.api.nvim_get_current_buf()
	local buf_windows = vim.call("win_findbuf", bufnr)
	local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
	if modified and #buf_windows == 1 then
		vim.ui.input({
			prompt = "You have unsaved changes. Quit anyway? (y/n) ",
		}, function(input)
			if input == "y" then
				vim.cmd("q!")
			end
		end)
	else
		vim.cmd("q!")
	end
end

-- toggles lazygit
function M.lazygit_toggle()
	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({
		cmd = "lazygit",
		hidden = true,
		direction = "float",
		float_opts = {
			border = "none",
			width = 100000,
			height = 100000,
		},
		on_open = function(_)
			vim.cmd("startinsert!")
		end,
		on_close = function(_) end,
		count = 99,
	})
	lazygit:toggle()
end

-- toggle diffview file_history
M.toggle_file_history = function()
	local view = lib.get_current_view()
	if view == nil then
		diffview.file_history()
		return
	end

	if view then
		view:close()
		lib.dispose_view(view)
	end
end

-- toggle diffview
M.toggle_status = function()
	local view = lib.get_current_view()
	if view == nil then
		diffview.open()
		return
	end

	if view then
		view:close()
		lib.dispose_view(view)
	end
end

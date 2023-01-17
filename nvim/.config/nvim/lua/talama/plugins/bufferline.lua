local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup({
  highlights = require("catppuccin.groups.integrations.bufferline").get(),
	options = {
		close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
		separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
	},
})

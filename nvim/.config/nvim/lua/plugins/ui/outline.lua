return {
	"hedyhli/outline.nvim",
	keys = { { "<leader>cs", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
	cmd = "Outline",
	opts = function()
		local defaults = require("outline.config").defaults
		local opts = {
			symbols = {
				icons = {},
			},
			keymaps = {
				up_and_jump = "<up>",
				down_and_jump = "<down>",
			},
		}
		return opts
	end,
}

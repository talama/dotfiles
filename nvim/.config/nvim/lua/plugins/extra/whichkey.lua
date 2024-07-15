return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	config = function()
		local wk = require("which-key")
		wk.add({
			mode = { "n", "v" },
			{ "g", group = "+goto" },
			{ "]", group = "+next" },
			{ "[", group = "+prev" },
			{ "<leader>b", group = "+buffer" },
			{ "<leader>c", group = "+code" },
			{ "<leader>d", group = "+debug" },
			{ "<leader>f", group = "+file/find" },
			{ "<leader>q", group = "+quit.session" },
			{ "<leader>s", group = "+search" },
			{ "<leader>u", group = "+ui" },
			{ "<leader>w", group = "+windows" },
			{ "<leader>x", group = "+diagnostics/quickfix" },
		})
	end,
}

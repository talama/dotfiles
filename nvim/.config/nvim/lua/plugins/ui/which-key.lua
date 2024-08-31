return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
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
			{ "<leader>gh", group = "+hunks" },
			{ "<leader>q", group = "+quit.session" },
			{ "<leader>s", group = "+search" },
			{ "<leader>t", group = "+tabs" },
			{ "<leader>u", group = "+ui" },
			{ "<leader>w", group = "+windows" },
			{ "<leader>x", group = "+diagnostics/quickfix" },
			{ "[", group = "prev" },
			{ "]", group = "next" },
			{ "g", group = "goto" },
		})
	end,
}

return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	opts = {
		indent = { char = "▎" },
		exclude = {
			filetypes = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"trouble",
				"Trouble",
				"lazy",
				"mason",
				"toggleterm",
				"lspinfo",
				"checkhealth",
				"man",
				"git",
				"markdown",
				"text",
			},
			buftypes = {
				"terminal",
				"nofile",
				"quickfix",
				"prompt",
			},
		},
	},
}

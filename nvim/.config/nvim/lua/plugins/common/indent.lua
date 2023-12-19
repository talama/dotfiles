-- Plugin: indent-blankline
-- url: https://github.com/lukas-reineke/indent-blankline.nvim

return {
	"lukas-reineke/indent-blankline.nvim",

	opts = {
		indent = { char = "▎" },
		exclude = {
			filetypes = {
				"lspinfo",
				"packer",
				"checkhealth",
				"help",
				"man",
				"dashboard",
				"git",
				"markdown",
				"text",
				"terminal",
				"NvimTree",
			},

			buftypes = {
				"terminal",
				"nofile",
				"quickfix",
				"prompt",
			},
		},
	},

	config = function(_, opts)
		require("ibl").setup(opts)
	end,
}

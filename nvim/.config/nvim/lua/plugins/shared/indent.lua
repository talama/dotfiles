return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
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

	-- config = function(_, opts)
	-- 	require("ibl").setup(opts)
	-- end,
}

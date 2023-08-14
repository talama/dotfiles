return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		},
		config = function()
			require("cmp").config.formatting = {
				format = require("tailwindcss-colorizer-cmp").formatter,
			}
		end,
	},
	{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
}

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		open_mapping = [[<C-t>]],
		shading_factor = 1,
		direction = "horizontal",
		float_opts = {
			width = math.floor(0.8 * vim.fn.winwidth(0)),
			height = math.floor(0.8 * vim.fn.winheight(0)),
			winblend = 0,
		},
	},
	config = true,
}

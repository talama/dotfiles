return {
	"allaman/emoji.nvim",
	version = "1.0.0", -- optionally pin to a tag
	ft = "markdown", -- adjust to your needs
	dependencies = {
		-- util for handling paths
		"nvim-lua/plenary.nvim",
		-- optional for nvim-cmp integration
		"hrsh7th/nvim-cmp",
	},
	opts = {
		-- default is false, also needed for blink.cmp integration!
		enable_cmp_integration = true,
		-- optional if your plugin installation directory
		-- is not vim.fn.stdpath("data") .. "/lazy/
		-- plugin_path = vim.fn.expand("$HOME/plugins/"),
	},
	config = function(_, opts)
		require("emoji").setup(opts)
	end,
}

return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			cssls = {
				settings = {
					css = {
						lint = {
							unknownAtRules = "ignore",
						},
					},
				},
			},
		},
	},
}

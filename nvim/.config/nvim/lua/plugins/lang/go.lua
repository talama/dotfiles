return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "go", "gomod", "gowork", "gosum" } },
	},
	{
		"williamboman/mason.nvim",
		opts = { ensure_installed = { "goimports", "gofumpt" } },
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = { ensure_installed = { "delve" } },
			},
			{
				"leoluz/nvim-dap-go",
				opts = {},
			},
		},
	},
	{
		"leoluz/nvim-dap-go",
		config = true,
	},
}

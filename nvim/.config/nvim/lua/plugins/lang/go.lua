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
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			-- "ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
}

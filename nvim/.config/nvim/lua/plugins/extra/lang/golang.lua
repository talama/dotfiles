return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"go",
				"gomod",
				"gowork",
				"gosum",
			})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, opts)
			if type(opts.sources) == "table" then
				local nls = require("null-ls")
				vim.list_extend(opts.sources, {
					nls.builtins.code_actions.gomodifytags,
					nls.builtins.code_actions.impl,
					nls.builtins.formatting.gofumpt,
					nls.builtins.formatting.goimports_reviser,
				})
			end
		end,
	},
	{
		"mfussenegger/nvim-dap",
		optional = true,
		dependencies = {
			{
				"mason.nvim",
				opts = function(_, opts)
					opts.ensure_installed = opts.ensure_installed or {}
					vim.list_extend(
						opts.ensure_installed,
						{ "gomodifytags", "impl", "gofumpt", "goimports-reviser", "delve" }
					)
				end,
			},
			{
				"leoluz/nvim-dap-go",
				config = true,
			},
		},
	},
	{
		"leoluz/nvim-dap-go",
		config = true,
	},
}

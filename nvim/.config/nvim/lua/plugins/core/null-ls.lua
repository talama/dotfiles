return {
	"jose-elias-alvarez/null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "mason.nvim" },
	opts = function()
		local null_ls = require("null-ls")
		return {
			sources = {
				null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.diagnostics.eslint_d,
				-- null_ls.builtins.formatting.eslint_d,
				null_ls.builtins.formatting.prettierd.with({
					extra_filetypes = { "toml" },
				}),
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.gofmt,
			},
		}
	end,
}

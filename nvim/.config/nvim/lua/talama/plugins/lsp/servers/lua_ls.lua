return {
	Lua = {
		diagnostics = {
			globals = { "vim", "require", "pcall" },
		},
		workspace = {
			library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				[vim.fn.stdpath("config") .. "/lua"] = true,
			},
		},
		telemetry = {
			enable = false,
		},
	},
}

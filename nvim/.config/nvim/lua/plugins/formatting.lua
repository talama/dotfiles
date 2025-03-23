local function first(bufnr, ...)
	local conform = require("conform")
	for i = 1, select("#", ...) do
		local formatter = select(i, ...)
		if conform.get_formatter_info(formatter, bufnr).available then
			return formatter
		end
	end
	return select(1, ...)
end

return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},

	opts = {
		-- Define your formatters
		formatters_by_ft = {
			gotmpl = { "prettier" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			svelte = { "prettier" },
			html = { "prettier" },
			css = function(bufnr)
				return { first(bufnr, "prettier"), "stylelint" }
			end,
			sass = function(bufnr)
				return { first(bufnr, "prettier"), "stylelint" }
			end,
			scss = function(bufnr)
				return { first(bufnr, "prettier"), "stylelint" }
			end,
			less = function(bufnr)
				return { first(bufnr, "prettier"), "stylelint" }
			end,
			json = { "prettier" },
			yaml = { "prettier" },
			["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
			["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
			graphql = { "prettier" },
			lua = { "stylua" },
			python = { "isort", "black" },
			go = { "gofumpt" },
			rust = { "rustfmt" },
		},
		-- Set default options
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- Set up format-on-save
		format_on_save = function(bufnr)
			-- Disable with a global or buffer-local variable
			-- see lua/config/autocmds.lua for the autocmd
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 1000, lsp_format = "fallback" }
		end,
		-- Customize formatters
		formatters = {},
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}

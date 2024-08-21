---@param bufnr integer
---@param ... string
---@return string
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
	lazy = true,
	event = { "BufEnter", "BufWritePre" },
	config = function()
		local conform = require("conform")
		local slow_format_filetypes = {}
		conform.setup({
			formatters_by_ft = {
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				svelte = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				css = function(bufnr)
					return { first(bufnr, "prettierd", "prettier"), "stylelint" }
				end,
				sass = function(bufnr)
					return { first(bufnr, "prettierd", "prettier"), "stylelint" }
				end,
				scss = function(bufnr)
					return { first(bufnr, "prettierd", "prettier"), "stylelint" }
				end,
				less = function(bufnr)
					return { first(bufnr, "prettierd", "prettier"), "stylelint" }
				end,
				json = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				graphql = { "prettierd", "prettier", stop_after_first = true },
				lua = { "stylua" },
				python = { "isort", "black" },
				go = { "goimports", "gofumpt" },
				rust = { "rustfmt" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_format = "fallback",
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}

return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufEnter", "BufWritePre" },
	config = function()
		local conform = require("conform")
		local slow_format_filetypes = {}
		conform.setup({
			formatters_by_ft = {
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				svelte = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
				css = { "stylelint", { "prettierd", "prettier" } },
				sass = { "prettierd", { "prettierd", "prettier" }},
				scss = { "prettierd", { "prettierd", "prettier" }},
				less = { "prettierd", { "prettierd", "prettier" } },
				json = { { "prettierd", { "prettierd", "prettier" } } },
				yaml = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
				graphql = { { "prettierd", "prettier" } },
				lua = { "stylua" },
				python = { "isort", "black" },
				go = { "goimports", "gofumpt" },
				rust = { "rustfmt" },
			},

			-- detect which formatters take too long to run synchronously and will run them async on save instead.
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				if slow_format_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				local function on_format(err)
					if err and err:match("timeout$") then
						slow_format_filetypes[vim.bo[bufnr].filetype] = true
					end
				end
				return { timeout_ms = 200, lsp_format = "fallback" }, on_format
			end,

			format_after_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				if not slow_format_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				return { lsp_format = "fallback" }
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_format = "fallback",
				async = true,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}

local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local M = {}

-- Avoiding LSP formatting conflicts and format on save toggle
function M.enable_format_on_save(bufnr)
	local group = vim.api.nvim_create_augroup("LspFormatting", {})
	vim.api.nvim_create_autocmd("BufWritePre", {
		callback = function()
			vim.lsp.buf.format({
				filter = function(client)
					-- apply whatever logic you want (in this example, we'll only use null-ls)
					return client.name == "null-ls"
				end,
				bufnr = bufnr,
			})
		end,
		group = group,
	})
	require("notify")("Enabled format on save", "info", { title = "LSP", timeout = 2000 })
end

function M.disable_format_on_save()
	vim.api.nvim_del_augroup_by_name("LspFormatting")
	require("notify")("Disabled format on save", "info", { title = "LSP", timeout = 2000 })
end

function M.toggle_format_on_save(bufnr)
	if vim.fn.exists("#LspFormatting#BufWritePre") == 0 then
		M.enable_format_on_save(bufnr)
	else
		M.disable_format_on_save()
	end
end

vim.api.nvim_create_user_command(
	"LspToggleAutoFormat",
	'lua require("talama.plugins.lsp.null-ls").toggle_format_on_save(bufnr)',
	{}
)

-- Null-ls
null_ls.setup({
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			M.enable_format_on_save(bufnr)
		end
	end,
	debug = false,
	sources = {
		formatting.prettier.with({
			extra_filetypes = { "toml" },
			extra_args = {},
		}),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		formatting.google_java_format,
		diagnostics.flake8,
	},
})

return M

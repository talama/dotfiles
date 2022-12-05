-- Setup installer & lsp configs
local typescript_ok, typescript = pcall(require, "typescript")
local mason_ok, mason = pcall(require, "mason")
local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")

if not mason_ok or not mason_lsp_ok or not cmp_ok then
	return
end

local servers = {
	"sumneko_lua",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"eslint",
	"emmet_ls",
}

mason.setup({
	ui = {
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

mason_lsp.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig = require("lspconfig")

-- Configure diagnostic
local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		signs = true,
		underline = false,
		update_in_insert = false,
		severity_sort = true,
		virtual_text = false,
	}),
}

local function on_attach(client, bufnr)
	-- set up buffer keymaps, etc.
end

local capabilities = cmp_lsp.default_capabilities()

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

if typescript_ok then
	typescript.setup({
		disable_commands = false, -- prevent the plugin from creating Vim commands
		debug = false, -- enable debug logging for commands
		-- LSP Config options
		server = {
			capabilities = require("talama.plugins.lsp.servers.tsserver").capabilities,
			handlers = handlers,
			on_attach = require("talama.plugins.lsp.servers.tsserver").on_attach,
		},
	})
end

lspconfig.eslint.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = require("talama.plugins.lsp.servers.eslint").on_attach,
	settings = require("talama.plugins.lsp.servers.eslint").settings,
})

lspconfig.sumneko_lua.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
	settings = require("talama.plugins.lsp.servers.sumneko_lua").settings,
})

lspconfig.cssls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = require("talama.plugins.lsp.servers.cssls").on_attach,
	settings = require("talama.plugins.lsp.servers.cssls").settings,
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
	settings = require("talama.plugins.lsp.servers.jsonls").settings,
})

for _, server in ipairs({ "bashls", "emmet_ls", "html", "pyright" }) do
	lspconfig[server].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = handlers,
	})
end

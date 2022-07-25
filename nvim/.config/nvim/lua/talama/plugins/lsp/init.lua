local installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not installer_ok then
	return
end

local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
	return
end

local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok then
	return
end

-- Servers to intall automatically.
local servers = {
	"sumneko_lua",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
}

-- Installer setup
lsp_installer.setup({
	ensure_installed = servers,
	automatic_installation = true,
	ui = {
		border = "rounded",
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
		keymaps = {
			-- Keymap to expand a server in the UI
			toggle_server_expand = "<CR>",
			-- Keymap to install the server under the current cursor position
			install_server = "i",
			-- Keymap to reinstall/update the server under the current cursor position
			update_server = "u",
			-- Keymap to check for new version for the server under the current cursor position
			check_server_version = "c",
			-- Keymap to update all installed servers
			update_all_servers = "U",
			-- Keymap to check which installed servers are outdated
			check_outdated_servers = "C",
			-- Keymap to uninstall a server
			uninstall_server = "X",
		},
	},
})

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

vim.diagnostic.config({
	virtual_text = true,
	signs = { active = signs },
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Handlers
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local function on_attach(client, bufnr)
	-- set up buffer keymaps, etc.
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Configure servers
--
lspconfig.tsserver.setup({
	capabilities = require("talama.plugins.lsp.servers.tsserver").capabilities,
	handlers = handlers,
	on_attach = require("talama.plugins.lsp.servers.tsserver").on_attach,
})

lspconfig.eslint.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = require("talama.plugins.lsp.servers.eslint").on_attach,
	settings = require("talama.plugins.lsp.servers.eslint").settings,
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
	settings = require("talama.plugins.lsp.servers.jsonls").settings,
})

lspconfig.sumneko_lua.setup({
	handlers = handlers,
	on_attach = on_attach,
	settings = require("talama.plugins.lsp.servers.sumneko_lua").settings,
})

for _, server in ipairs({ "bashls", "cssls", "html" }) do
	lspconfig[server].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = handlers,
	})
end

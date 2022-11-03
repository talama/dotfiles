local ok, mason = pcall(require, "mason")
if not ok then
  return
end

--- Servers to install automatically
local servers = {
  "sumneko_lua",
  "eslint",
  "emmet_ls",
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
}

mason.setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
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
	update_in_insert = false,
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
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

-- Servers capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Lsp keymaps
local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  -- shorten function name
  local keymap = vim.api.nvim_buf_set_keymap
  local function map(shortcut, command)
    keymap(bufnr, "n", shortcut, command, opts)
  end
  -- mappings
  map("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  map("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  map("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  map("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  map("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  map("dg", "<cmd>lua vim.diagnostic.open_float()<CR>")
  map("<leader>dj", "<cmd>lua vim.diagnostic.goto_next()<CR>")
  map("<leader>dk", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  map("<leader>dq", "<cmd>lua vim.diagnostic.setloclist()<CR>")
  map("<leader>bf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>")
  map("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
  map("<leader>br", "<cmd>lua vim.lsp.buf.rename()<cr>")
  map("<leader>bs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
end

-- General on_attach
local on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  lsp_keymaps(bufnr)
  local ill_ok, illuminate = pcall(require, "illuminate")
  if not ill_ok then
    return
  end
  illuminate.on_attach(client)
end

-- LSP config
local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
  return
end

local default_opts = {}

-- Configure the installed servers
for _, server in pairs(servers) do
  default_opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  server = vim.split(server, "@")[1]
  -- check if special options for the current server exists and add it to default options
  local options_exist, special_opts = pcall(require, "talama.plugins.lsp.servers." .. server)
  if options_exist then
    default_opts = vim.tbl_deep_extend("force", special_opts, default_opts)
  end
  lspconfig[server].setup(default_opts)
end

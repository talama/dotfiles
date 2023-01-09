-- MASON settings
require("mason.settings").set({
	ui = {
		border = "rounded",
	},
})

-- lsp-zero
local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.ensure_installed({
	"sumneko_lua",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"eslint",
	"emmet_ls",
})

-- Configure lsp servers.
-- sumneko_lua
lsp.configure("sumneko_lua", {
	settings = require("talama.plugins.lsp.servers.sumneko_lua"),
})
-- json
lsp.configure("jsonls", {
	settings = require("talama.plugins.lsp.servers.jsonls"),
})

-- CMP
-- Complete from all visible buffers (splits)
local buffer_option = {
	get_bufnrs = function()
		local bufs = {}
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			bufs[vim.api.nvim_win_get_buf(win)] = true
		end
		return vim.tbl_keys(bufs)
	end,
}
-- Mappings
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "c" }),
	["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "c" }),
	["<C-e>"] = cmp.mapping({
		i = cmp.mapping.abort(),
		c = cmp.mapping.close(),
	}),
})

lsp.setup_nvim_cmp({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer", option = buffer_option },
		{ name = "path" },
		{ name = "npm" },
	},
	mappings = cmp_mappings,
})

--LSP
lsp.set_preferences({
	sign_icons = {
		error = " ",
		warn = " ",
		hint = "",
		info = " ",
	},
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "ge", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	vim.keymap.set("n", "<leader>lm", "<cmd>Mason<cr>", opts)
	vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>lj", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)

	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end)

lsp.setup()

vim.diagnostic.config({
	signs = true,
	underline = false,
	update_in_insert = false,
	severity_sort = true,
	virtual_text = true,
})

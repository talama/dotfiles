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
	"lua_ls",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"eslint",
	"emmet_ls",
	"clangd",
})

-- Configure lsp servers.
-- sumneko_lua
lsp.configure("lua_ls", {
	settings = require("talama.plugins.lsp.servers.lua_ls"),
})
-- json
lsp.configure("jsonls", {
	settings = require("talama.plugins.lsp.servers.jsonls"),
})

-- CMP
-- Complete from all visible buffers (splits)
-- local buffer_option = {
-- 	get_bufnrs = function()
-- 		local bufs = {}
-- 		for _, win in ipairs(vim.api.nvim_list_wins()) do
-- 			bufs[vim.api.nvim_win_get_buf(win)] = true
-- 		end
-- 		return vim.tbl_keys(bufs)
-- 	end,
-- }
-- -- Mappings
-- local cmp = require("cmp")
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
-- 	["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
-- 	["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
-- 	["<C-y>"] = cmp.mapping.confirm({ select = true }),
-- 	["<C-Space>"] = cmp.mapping.complete(),
-- 	["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "c" }),
-- 	["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "c" }),
-- 	["<C-e>"] = cmp.mapping({
-- 		i = cmp.mapping.abort(),
-- 		c = cmp.mapping.close(),
-- 	}),
-- })
--
-- lsp.setup_nvim_cmp({
-- 	sources = {
-- 		{ name = "nvim_lsp", priority = 10 },
-- 		{ name = "nvim_lua", prioriyt = 5 },
-- 		{ name = "luasnip", priority = 7, max_item_count = 8 },
-- 		{ name = "buffer", priority = 7, option = buffer_option },
-- 		{ name = "path", priority = 4 },
-- 		{ name = "npm", priority = 3 },
-- 	},
-- 	mappings = cmp_mappings,
-- })

lsp.setup_nvim_cmp({})

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
	vim.keymap.set("n", "<leader>lt", "<cmd>TroubleToggle<cr>", opts)

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

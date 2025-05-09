return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	cmd = "Mason",
	build = ":MasonUpdate",
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
	config = function(_, opts)
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup(opts)
		mason_lspconfig.setup({
			ensure_installed = {
				"cssls",
				"emmet_ls",
				"gopls",
				"graphql",
				"html",
				"lua_ls",
				"prismals",
				"pyright",
				"svelte",
				"tailwindcss",
				"templ",
				"vtsls",
				-- "eslint",
				"jsonls",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"prettierd",
				"stylua",
				"isort",
				"markdownlint-cli2",
				"markdown-toc",
				"black",
				"pylint",
				"eslint_d",
				"stylelint",
				"gofumpt",
				"goimports",
				"js-debug-adapter",
			},
		})
	end,
}

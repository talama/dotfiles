return {
	"VonHeikemen/lsp-zero.nvim",
	config = function()
		local lsp = require("lsp-zero").preset({})
		lsp.on_attach(function(_, bufnr)
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
		end)

		lsp.set_sign_icons({
			error = " ",
			warn = " ",
			hint = " ",
			info = " ",
		})
		-- (Optional) Configure lua language server for neovim
		require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

		lsp.setup()

		-- Diagnostic
		vim.diagnostic.config({
			signs = true,
			underline = false,
			update_in_insert = false,
			severity_sort = true,
			virtual_text = false,
		})

		-- You need to setup `cmp` after lsp-zero
		local cmp = require("cmp")
		local cmp_action = require("lsp-zero").cmp_action()
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			-- disable completion in comments
			enabled = function()
				local context = require("cmp.config.context")
				-- keep command mode completion enabled when cursor is in a comment
				if vim.api.nvim_get_mode().mode == "c" then
					return true
				else
					return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
				end
			end,

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				-- `Enter` key to confirm completion
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				-- Ctrl+Space to trigger completion menu
				["<C-Space>"] = cmp.mapping.complete(),
				-- Navigate between snippet placeholder
				["<C-f>"] = cmp_action.luasnip_jump_forward(),
				["<C-b>"] = cmp_action.luasnip_jump_backward(),
				-- Super Tab
				["<Tab>"] = cmp_action.luasnip_supertab(),
				["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "nvim_lua" },
			},
			{
				{ name = "buffer" },
			},
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
			}, {
				{ name = "buffer" },
			}),
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}

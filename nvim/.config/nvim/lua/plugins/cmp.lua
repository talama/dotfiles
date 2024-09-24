return {
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
			"saadparwaiz1/cmp_luasnip",

			-- Adds other completion capabilities.
			-- nvim-cmp does not ship with all sources by default. They are split
			-- into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp", -- lsp completion
			"hrsh7th/cmp-path", -- source for file system paths
			"hrsh7th/cmp-buffer", -- source for text in buffer
			{ "roobert/tailwindcss-colorizer-cmp.nvim", opts = { color_square_width = 2 } },

			-- vscode-like pictograms to neovim built-in lsp
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local luasnip = require("luasnip")
			luasnip.config.setup({})
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert,noselect" },
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				-- Keymaps
				mapping = cmp.mapping.preset.insert({
					-- confirm completion and supertab
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					-- select next/previous item
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					-- trigger completion menu
					["<C-Space>"] = cmp.mapping.complete(),
					-- close completion menu
					["<C-e>"] = cmp.mapping.abort(),
					-- Navigate between snippet placeholder
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					fields = { "abbr", "kind", "menu" },
					expandable_indicator = true,
					format = lspkind.cmp_format({
						mode = "symbol_text",
						menu = {
							nvim_lsp = "[LSP]",
							luasnip = "[SNP]",
							buffer = "[BUF]",
							path = "[PTH]",
						},
						maxwith = 50,
						ellipsis_char = "...",
						before = function(entry, vim_item)
							vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
							return vim_item
						end,
					}),
				},
			})
		end,
	},
}

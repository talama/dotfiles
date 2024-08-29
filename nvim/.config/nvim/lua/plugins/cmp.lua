return {
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- lsp completion
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"hrsh7th/cmp-path", -- source for file system paths
			"garymjr/nvim-snippets", -- allows vscode style snippets with vim.snippet
			"onsails/lspkind.nvim", -- vscode-like pictograms to neovim built-in lsp
			"rafamadriz/friendly-snippets",
			{ "roobert/tailwindcss-colorizer-cmp.nvim", opts = { color_square_width = 2 } },
		},
		opts = function()
			-- function for super-tab
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local auto_select = true
			return {
				completion = {
					completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
				},
				preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					-- confirm completion
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					-- trigger completion menu
					["<C-Space>"] = cmp.mapping.complete(),
					-- close completion menu
					["<C-e>"] = cmp.mapping.abort(),
					-- Navigate between snippet placeholder
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif vim.snippet.active({ direction = 1 }) then
							vim.schedule(function()
								vim.snippet.jump(1)
							end)
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif vim.snippet.active({ direction = -1 }) then
							vim.schedule(function()
								vim.snippet.jump(-1)
							end)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "snippets" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
				formatting = {
					fields = { "abbr", "kind", "menu" },
					expandable_indicator = true,
					format = lspkind.cmp_format({
						mode = "symbol_text",
						menu = {
							buffer = "[BUfF",
							nvim_lsp = "[LSP]",
							path = "[PTH]",
							snippets = "[SNP]",
						},
						maxwith = 50,
						ellipsis_char = "...",
						before = function(entry, vim_item)
							vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
							return vim_item
						end,
					}),
				},
			}
		end,
	},
	{
		"garymjr/nvim-snippets",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			friendly_snippets = true,
		},
	},
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		dependencies = {
			-- set commentstirng for files that support multiple embedded languages
			"JoosepAlviste/nvim-ts-context-commentstring",
			-- autoclose/rename html tags
			"windwp/nvim-ts-autotag",
			-- syntax aware text-objects
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				vim.filetype.add({
					extension = {
						gotmpl = "gotmpl",
						gohtml = "gotmpl",
						gohtmltmpl = "gotmpl",
						gohtxttmpl = "gotmpl",
						gohtexttmpl = "gotmpl",
					},
				}),
				highlight = { enable = true, additional_vim_regex_highlighting = false },
				indent = {
					enable = true,
				},
				ensure_installed = {
					"astro",
					"bash",
					"c",
					"cpp",
					"css",
					"go",
					"gotmpl",
					"html",
					"javascript",
					"jsdoc",
					"json",
					"jsonc",
					"lua",
					"luadoc",
					"markdown",
					"ninja",
					"python",
					"regex",
					"rst",
					"scss",
					"sql",
					"svelte",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"vue",
					"xml",
					"yaml",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
			require("ts_context_commentstring").setup()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				per_filetype = {},
			})
		end,
	},
}

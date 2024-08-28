return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
      -- set commentstirng for files that support multiple embedded languages
			"JoosepAlviste/nvim-ts-context-commentstring",
      -- autoclose/rename html tags
			"windwp/nvim-ts-autotag",
      -- syntax aware text-objects
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"astro",
				"bash",
				"c",
				"cpp",
				"css",
				"go",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"markdown",
				"python",
				"regex",
				"scss",
				"sql",
				"svelte",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
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
		},
		config = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				local added = {}
				opts.ensure_installed = vim.tbl_filter(function(lang)
					if added[lang] then
						return false
					end
					added[lang] = true
					return true
				end, opts.ensure_installed)
			end
			require("ts_context_commentstring").setup()
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"windwp/nvim-ts-autotag",
	},
}


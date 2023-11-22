return {
	"nvim-treesitter/nvim-treesitter",
	version = false, -- last release is way too old and doesn't work on Windows
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		-- { "nvim-treesitter/nvim-treesitter-textobjects", }
	},
	cmd = { "TSUpdateSync" },
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		ensure_installed = {
			"astro",
			"bash",
			"c",
			"css",
			"html",
			"javascript",
			"jsdoc",
			"json",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"scss",
			"svelte",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<c-space>",
				node_incremental = "<c-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
		-- context_commentstring = {
		-- 	enable = true,
		-- },
		autotag = {
			enable = true,
			enable_rename = true,
			enable_close = true,
			enable_close_on_slash = true,
			filetypes = { "html", "xml" },
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
}

local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

configs.setup({
	ensure_installed = "all",
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true,
		-- disable = { "" },  -- list of language that will be disabled
		-- additional_vim_regex_highlighting = false,
	},

	incremental_selection = {
		enable = false,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "gnr",
			scope_incremental = "gne",
			node_decremental = "gnt",
		},
	},

	indent = {
		enable = true,
	},

	rainbow = {
		enable = true,
	},

	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},

	textobjects = {
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]]"] = "@function.outer",
				["]m"] = "@class.outer",
			},
			goto_next_end = {
				["]["] = "@function.outer",
				["]M"] = "@class.outer",
			},
			goto_previous_start = {
				["[["] = "@function.outer",
				["[m"] = "@class.outer",
			},
			goto_previous_end = {
				["[]"] = "@function.outer",
				["[M"] = "@class.outer",
			},
		},
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["~"] = "@parameter.inner",
			},
		},
	},
})

local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

treesitter.setup({
	-- A list of parser names, or "all"
	ensure_installed = { "help", "c", "javascript", "typescript", "html", "css", "markdown", "markdown_inline", "lua", "rust" },
	-- List of parsers to ignore installing (for "all")
	ignore_install = { "" },
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of languages that will be disabled
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			scope_incremental = "<TAB>",
			node_decremental = "<S-TAB>",
		},
	},
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	indent = {
		enable = true,
		disable = { "" },
	},
	rainbow = {
		enable = true,
		extended = true, -- Highlight also non parentheses delimiters
		max_file_lines = 1000,
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

	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
})

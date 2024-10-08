return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			enabled = vim.fn.executable("make") == 1,
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},
	keys = {
		{
			"<leader>,",
			"<cmd>Telescope buffers sort_mru=true<cr>",
			desc = "Switch Buffer",
		},
		{
			"<leader>:",
			"<cmd>Telescope command_history<cr>",
			desc = "Command History",
		},
		-- find
		{ "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", desc = "Find all" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>ff", "<cmd> Telescope find_files <CR>", desc = "Find files" },
		{ "<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "Help page" },
		{ "<leader>fr", "<cmd> Telescope oldfiles <CR>", desc = "Recent" },
		{ "<leader>fw", "<cmd> Telescope live_grep <CR>", desc = "Live grep" },
		-- git
		{ "<leader>fc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
		{ "<leader>fg", "<cmd> Telescope find_files <CR>", desc = "Find files" },
		{ "<leader>fs", "<cmd>Telescope git_status<CR>", desc = "status" },
		-- search
		{
			"<leader>sa",
			"<cmd>Telescope autocommands<cr>",
			desc = "Auto Commands",
		},
		{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
		{ "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
		{ "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
		{ "<leader>sh", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
		{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
		{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
		{
			"<leader>ss",
			function()
				require("telescope.builtin").lsp_document_symbols({})
			end,
			desc = "Goto Symbol",
		},
		{ "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
		{
			"<leader>sw",
			"<cmd>Telescope grep_string<cr>",
			desc = "Find string under cursor",
		},
		{
			"<leader>sW",
			"<cmd>Telescope grep_string root=false<cr>",
			desc = "Find string under cursor in cwd",
		},
	},
	opts = {
		defaults = {
			prompt_prefix = "   ",
			file_ignore_patterns = { ".git/", "node_modules" },
			color_devicons = true,
			mappings = {
				i = {
					["<C-n>"] = function(...)
						return require("telescope.actions").cycle_history_next(...)
					end,
					["<C-p>"] = function(...)
						return require("telescope.actions").cycle_history_prev(...)
					end,
					["<C-j>"] = function(...)
						return require("telescope.actions").move_selection_next(...)
					end,
					["<C-k>"] = function(...)
						return require("telescope.actions").move_selection_previous(...)
					end,
					["<C-b>"] = function(...)
						return require("telescope.actions").preview_scrolling_up(...)
					end,
					["<C-f>"] = function(...)
						return require("telescope.actions").preview_scrolling_down(...)
					end,
				},
				n = {
					["<C-c>"] = function(...)
						return require("telescope.actions").close(...)
					end,
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	},
}

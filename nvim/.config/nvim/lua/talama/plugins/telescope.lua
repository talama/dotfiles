local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
	return
end

local actions_ok, actions = pcall(require, "telescope.actions")
if not actions_ok then
	return
end

local git_icons = {
	added = "  ",
	changed = " 柳",
	copied = ">",
	deleted = "  ",
	renamed = "➡",
	unmerged = "‡",
	untracked = "?",
}

telescope.setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		prompt_prefix = "🔍 ",
		selection_caret = "❯ ",
		entry_prefix = "  ",
		git_icons = git_icons,
		color_devicons = true,

		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",

		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},

		file_ignore_patterns = {
			".git/",
			"node_modules",
		},

		vimgrep_arguments = {
			"rg",
			"--ignore",
			"--hidden",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--trim",
		},

		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-n>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,
				["<C-c>"] = actions.close,
				["<C-j>"] = actions.cycle_history_next,
				["<C-k>"] = actions.cycle_history_prev,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
				["<CR>"] = actions.select_default,
				["<C-h>"] = "which_key",
			},
			n = {
				["<C-n>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
			},
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},

		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
			}),
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")

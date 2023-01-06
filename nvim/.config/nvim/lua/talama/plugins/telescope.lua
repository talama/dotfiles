local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
	return
end

telescope.setup({
	defaults = {
		prompt_prefix = "   ",
		selection_caret = "❯ ",
		sorting_strategy = "ascending",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },
		color_devicons = true,
		dynamic_preview_title = true,
	},
	mappings = {},
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
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})
-- After setup function
require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")

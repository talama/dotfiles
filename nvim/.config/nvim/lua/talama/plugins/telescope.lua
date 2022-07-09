local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.load_extension('media_files')
telescope.load_extension('fzf')
telescope.load_extension("ui-select")
telescope.load_extension("live_grep_args")

local actions = require('telescope.actions')

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
    file_ignore_patterns = { "node_modules" },
    path_display         = { "smart" },
    vimgrep_arguments    = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    layout_config        = {
      horizontal = {
        preview_cutoff = 120,
      },
      prompt_position = "top",
    },
    file_sorter          = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix        = ' 🔍 ',
    color_devicons       = true,

    git_icons = git_icons,

    sorting_strategy = "ascending",

    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    mappings = {
      i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<CR>"] = actions.select_default,
      },
      n = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = true,
      -- find_command = { "find", "-type", "f" },
      -- find_command = { "fd", "-H", "-I" }, -- "-H" search hidden files, "-I" do not respect to gitignore
    },

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

    -- fzf syntax
    -- Token	Match type	Description
    -- sbtrkt	fuzzy-match	Items that match sbtrkt
    -- 'wild'	exact-match (quoted)	Items that include wild
    -- ^music	prefix-exact-match	Items that start with music
    -- .mp3$	suffix-exact-match	Items that end with .mp3
    -- !fire	inverse-exact-match	Items that do not include fire
    -- !^music	inverse-prefix-exact-match	Items that do not start with music
    -- !.mp3$	inverse-suffix-exact-match	Items that do not end with .mp3
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        -- even more opts
      }),
    },
    live_grep_args = {
      auto_quoting = false, -- enable/disable auto-quoting
    },
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
})

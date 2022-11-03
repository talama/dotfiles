local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then
  return
end

treesitter.setup({
  -- A list of parser names, or "all"
  ensure_installed = { "javascript", "typescript", "html", "css", "markdown", "markdown_inline", "lua", "rust" },
  -- List of parsers to ignore installing (for "all")
  ignore_install = { "" },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {""}, -- list of languages that will be disabled
    additional_vim_regex_highlighting = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<TAB>",
      node_decremental = "<S-TAB>",
    }
  },
  autopairs = {
		enable = true,
	},
	indent = {
    enable = true,
    disable = {""}
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
})

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
	},
  context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})

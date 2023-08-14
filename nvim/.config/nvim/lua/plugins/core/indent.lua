return  {
  'lukas-reineke/indent-blankline.nvim',
  opts = {
    buftype_exclude = { "terminal", "nofile", "prompt", "quickfix"},
	  filetype_exclude = { 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'dashboard', 'git', 'markdown', 'text', 'terminal', "Trouble", "TelescopePrompt", "Float" },
	  show_current_context = true,
	  show_current_context_start = false,
	  show_end_of_line = false,
	  show_trailing_blankline_indent = false,
	  space_char_blankline = " ",
	  use_treesitter = true,
  }
}

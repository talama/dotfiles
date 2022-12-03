if vim.g.vscode then
	print("vscode")
else
	print("nvim")
	require("talama.impatient")
	require("talama.options")
	require("talama.keymaps")
	require("talama.plugins")
	require("talama.colorscheme")
	require("talama.plugins.lsp")
end

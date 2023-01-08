if vim.g.vscode then
	print("vscode")
	require("talama.vscode.settings")
else
	require("talama.impatient")
	require("talama.options")
	require("talama.keymaps")
	require("talama.plugins")
	require("talama.colorscheme")
	require("talama.plugins.lsp")
end

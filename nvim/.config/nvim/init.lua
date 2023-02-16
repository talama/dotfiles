if vim.g.vscode then
	print("your mom")
	require("talama.vscode.settings")
	require("talama.vscode.options")
	require("talama.vscode.keymaps")
  require("talama.colorscheme")
else
	require("talama.impatient")
	require("talama.options")
	require("talama.keymaps")
	require("talama.plugins")
	require("talama.colorscheme")
	require("talama.plugins.lsp")
end

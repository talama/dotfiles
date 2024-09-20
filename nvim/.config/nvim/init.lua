require("config/options")
require("config/keymaps")
if vim.g.vscode then
	require("config/keymaps_vscode")
end
require("config/autocmds")
require("config/lazy")

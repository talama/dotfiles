local colorscheme = "catpuccin"

if colorscheme == "onedarkpro" then
	require("talama.plugins.colorschemes.onedarkpro")
	vim.cmd("colorscheme onedark")
elseif colorscheme == "catpuccin" then
	require("talama.plugins.colorschemes.catpuccin")
end

local colorscheme = "onedarkpro"

if colorscheme == "onedarkpro" then
	require("talama.plugins.colorschemes.onedarkpro")
	vim.cmd("colorscheme onedark")
elseif colorscheme == "catpuccin" then
	require("talama.plugins.colorschemes.catpuccin")
end

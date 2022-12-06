local colorscheme = "onedarkpro"

if colorscheme == "onedark" then
	require("onedark").setup({
		style = "dark",
	})
	require("onedark").load()
elseif colorscheme == "onedarkpro" then
	require("onedarkpro").setup({
		theme = "onedark_vivid",
		highlights = {
			["@variable.javascript"] = { fg = "${yellow}" },
		},
		styles = {
			types = "NONE",
			numbers = "NONE",
			strings = "NONE",
			comments = "italic",
			keywords = "NONE",
			constants = "NONE",
			functions = "NONE",
			operators = "NONE",
			variables = "NONE",
			conditionals = "NONE",
			virtual_text = "NONE",
		},
		options = {
			bold = false,
			cursorline = true,
			transparency = true,
		},
	})
	vim.cmd("colorscheme onedarkpro")
elseif colorscheme == "darkplus" then
	vim.cmd("colorscheme darkplus")
else
	vim.cmd("colorscheme darkblue")
end

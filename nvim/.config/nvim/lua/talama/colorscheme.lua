local colorscheme = "onedarkpro"

if colorscheme == "onedark" then
	require("onedark").setup({
		style = "dark",
	})
	require("onedark").load()
elseif colorscheme == "onedarkpro" then
	require("onedarkpro").setup({
		theme = "onedark",
		highlights = {
			Hlargs = { fg = "${red}" },
			SpecialComment = { fg = "${orange}" },
			NvimTreeFolderIcon = { fg = "${blue}" },
			NvimTreeFolderName = { fg = "${blue}" },
			NvimTreeOpenedFolderName = { fg = "${blue}" },
			NvimTreeRootFolder = { fg = "${orange}" },
			NvimTreeJsonIcon = { fg = "${yellow}" },
			NvimTreeVimIcon = { fg = "${white}" },
			NvimTreeTextIcon = { fg = "${white}" },
			["@variable.javascript"] = { fg = "${yellow}" },
			["@parameter.javascript"] = { fg = "${red}", style = "italic" },
			["@parameter.reference.javascript"] = { fg = "${red}", style = "italic" },
			["@property"] = { fg = "${red}" },
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

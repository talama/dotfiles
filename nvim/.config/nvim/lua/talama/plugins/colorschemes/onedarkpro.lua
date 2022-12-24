require("onedarkpro").setup({
	theme = "onedark",
	highlights = {
		Hlargs = { fg = "${yellow}" },
		SpecialComment = { fg = "${orange}" },
		NvimTreeFolderIcon = { fg = "${blue}" },
		NvimTreeFolderName = { fg = "${blue}" },
		NvimTreeOpenedFolderName = { fg = "${blue}" },
		NvimTreeRootFolder = { fg = "${orange}" },
		NvimTreeJsonIcon = { fg = "${yellow}" },
		NvimTreeVimIcon = { fg = "${white}" },
		NvimTreeTextIcon = { fg = "${white}" },
		["@variable.javascript"] = { fg = "${white}" },
		["@parameter.javascript"] = { fg = "${yellow}", style = "italic" },
		["@parameter.reference.javascript"] = { fg = "${yellow}", style = "italic" },
		["@property"] = { fg = "${yellow}" },
		["@method.call.javascript"] = { fg = "${blue}", style = "NONE" },
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

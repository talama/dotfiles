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
			comments = "italic",
		},
		options = {
			cursorline = true,
			transparency = true,
		},
	})
	vim.cmd("colorscheme onedarkpro")
else
	vim.cmd("colorscheme darkblue")
end

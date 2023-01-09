local ok, lualine = pcall(require, "lualine")
if not ok then
	return
end

local diagnostic = {
	"diagnostic",
	sources = { "nvim-diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = true,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = true,
	-- changes diff symbols
	symbols = { added = "", modified = "", removed = "" },
}

local filetype = {
	"filetype",
	icons_enabled = false,
}

local location = {
	"location",
	padding = 0,
}

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { "filename", diff },
		lualine_d = { diagnostic },
		lualine_x = { "fileformat", "encoding", filetype },
		lualine_y = { location },
		lualine_z = { "progress" },
	},
})

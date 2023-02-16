require("catppuccin").setup({
	flavour = "macchiato", -- latte, frappe, macchiato, mocha
	background = {
		-- :h background
		light = "latte",
		dark = "macchiato",
	},
	transparent_background = false,
	term_colors = true,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	no_italic = false, -- Force no italic
	no_bold = false, -- Force no bold
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	color_overrides = {
		all = {},
		latte = {},
		frappe = {},
		macchiato = {},
		mocha = {},
	},
	-- Global highlight groups
	custom_highlights = function(colors)
		return {
			["@variable"] = { fg = colors.text, style = {} },
			["@property"] = { fg = colors.teal, style = {} },
			["@method.call"] = { fg = colors.blue },
			["@type"] = { fg = colors.yellow },
			Hlargs = { fg = colors.yellow },
		}
	end,
	-- Per flavour overrides
	highlight_overrides = {
		all = function(colors) end,
		frappe = function(colors) end,
		macchiato = function(colors) end,
		mocha = function(colors) end,
	},
	integrations = {
		bufferline = true,
		gitsigns = true,
		indent_blankline = { enabled = true, colored_indent_levels = false },
		markdown = true,
		mason = true,
		cmp = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		nvimtree = true,
		treesitter = true,
		telescope = true,
		lsp_trouble = true,
		which_key = true,
		illuminate = true,
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")

return {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
  name = "catppuccin",

	config = function()
		require("catppuccin").setup({
			compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
			flavour = "macchiato",
			background = {
				-- :h background
				light = "latte",
				dark = "macchiato",
			},
			darkmode = true,
			transparent_background = false,
			show_end_of_buffer = false,
			term_colors = false,
			dim_inactive = {
				enabled = true,
				shade = "dark",
				percentage = 0.1,
			},
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
			color_overrides = {},
			custom_highlights = function(colors)
				return {
					["@variable"] = { fg = colors.text, style = {} },
					["@parameter"] = { fg = colors.teal },
					-- ["@property"] = { fg = colors.red, style = {} },
					-- ["method.call"] = { fg = colors.blue },
					["@type"] = { fg = colors.yellow },
					["@lsp.typemod.variable.readonly"] = { fg = colors.yellow },
					["@function.builtin"] = { fg = colors.blue },
				}
			end,
			default_integrations = true,
			integrations = {
				alpha = true,
				cmp = true,
				dap = true,
				dap_ui = true,
				flash = true,
				gitsigns = true,
				illuminate = true,
				indent_blankline = { enabled = true },
				lsp_trouble = true,
				mason = true,
				markdown = true,
				mini = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				navic = { enabled = true },
				neotest = true,
				noice = true,
				notify = true,
				neotree = true,
				semantic_tokens = true,
				telescope = true,
				treesitter = true,
				which_key = true,
			},
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}

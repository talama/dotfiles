return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	cmd = "Neotree",
	config = function()
		local wk = require("which-key")
		wk.register({
			["<leader>e"] = { "<cmd>Neotree toggle<CR>", "Explorer" },
		})

		-- If you want icons for diagnostic errors, you'll need to define them somewhere:
		vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,

			source_selector = {
				sources = { -- table
					{
						source = "filesystem", -- string
						display_name = " 󰉓 Files ", -- string | nil
					},
					{
						source = "buffers", -- string
						display_name = " 󰈚 Buffers ", -- string | nil
					},
					{
						source = "git_status", -- string
						display_name = " 󰊢 Git ", -- string | nil
					},
				},
			},
			window = {
				position = "left",
				width = 35,
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false,
				},
			},
			buffers = {
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				group_empty_dirs = true,
			},
		})
	end,
}

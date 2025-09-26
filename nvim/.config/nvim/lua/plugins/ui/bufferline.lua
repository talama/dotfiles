return {
	"akinsho/bufferline.nvim",
	after = "catppuccin",
	dependencies = { "nvim-tree/nvim-web-devicons", "nvim-mini/mini.bufremove" },
	version = "*",
	event = "VeryLazy",
	keys = {
		{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
		{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
		{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
	},
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			highlights = require("catppuccin.special.bufferline").get_theme(),
			options = {
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
				diagnostics = "nvim_lsp",
				-- offsets = { { filetype = "neo-tree", text = "Neo-Tree", padding = 1 } },
				offsets = {
					{
						filetype = "snacks_layout_box",
						text = "󰙅  File Explorer",
						separator = true,
					},
				},
				separator_style = "slant",
			},
		})
	end,
}

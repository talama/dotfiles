return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "echasnovski/mini.bufremove" },
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
			highlights = require("catppuccin.groups.integrations.bufferline").get(),
			options = {
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
				diagnostics = "nvim_lsp",
				offsets = { { filetype = "neo-tree", text = "Neo-Tree", padding = 1 } },
				separator_style = "slant",
			},
		})
	end,
}

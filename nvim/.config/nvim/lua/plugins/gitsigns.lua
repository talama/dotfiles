return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = " ▎" },
			change = { text = " ┆ " },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = " ▎" },
			untracked = { text = " ~ " },
		},
		signs_staged = {
			add = { text = " ▎" },
			change = { text = " ┆ " },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = " ▎" },
		},
		on_attach = function(buffer)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
			end

      -- stylua: ignore start
      map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
      map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
      map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
      map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")

      map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")

      map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")

      map("n", "<leader>hp", gs.preview_hunk_inline, "Preview Hunk Inline")

      map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")

      map("n", "<leader>hd", gs.diffthis, "Diff This")
      map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
      map({ "o", "x" }, "hs", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
		end,
	},
}

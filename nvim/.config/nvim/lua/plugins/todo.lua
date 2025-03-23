return {
	-- Finds and lists all of the TODO, HACK, BUG, etc comment in your project and loads them into a browsable list
	"folke/todo-comments.nvim",
	cmd = { "TodoTrouble", "TodoTelescope" },
	opts = {},
  -- stylua: ignore
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
    { "<leader>tx", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    { "<leader>Tx", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
    { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
  },
}

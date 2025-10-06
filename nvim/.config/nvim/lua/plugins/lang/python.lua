local function get_path(pkg, path)
	pcall(require, "mason")
	local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
	return root .. "/packages/" .. pkg .. "/" .. path
end

return {
	{
		"mfussenegger/nvim-dap-python",
	 -- stylua: ignore
	 keys = {
	   { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
	   { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
	 },
		config = function()
			if vim.fn.has("win32") == 1 then
				require("dap-python").setup(get_path("debugpy", "/venv/Scripts/pythonw.exe"))
			else
				require("dap-python").setup(get_path("debugpy", "/venv/bin/python"))
			end
		end,
	},
}

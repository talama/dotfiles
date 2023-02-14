local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
	return
end

local dap_ui_ok, dapui = pcall(require, "dapui")
if not dap_ui_ok then
	return
end

local dap_vt_ok, dap_vt = pcall(require, "nvim-dap-virtual-text")
if not dap_vt_ok then
	return
end

local keymap = vim.keymap.set
-- Silent keymap option
local opts = { noremap = true, silent = true }

-- Function for normal mode
local function nmap(shortcut, command)
	keymap("n", shortcut, command, opts)
end

-- DAP virtual text setup
dap_vt.setup({
	enabled = true,
	enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle
	highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
	highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
	show_stop_reason = true, -- show stop reason when stopped for exceptions
	commented = false, -- prefix virtual text with comment string
	only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
	all_references = false, -- show virtual text on all all references of the variable (not only definitions)
	filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
	-- Experimental Features:
	virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
	all_frames = false, -- show virtual text for all stack frames not only current.
	virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
	virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
})

-- DAP UI setup
dapui.setup({
	expand_lines = true,
	icons = { expanded = "", collapsed = "", circular = "" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	layouts = {
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				{ id = "scopes", size = 0.25 },
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 40, -- 40 columns
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 0.25, -- 25% of total lines
			position = "bottom",
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "rounded", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
	},
})

-- Icons
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

-- DAP setup
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- Keybindings
local continue = function()
	if vim.fn.filereadable(".vscode/launch.json") then
		require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })
	end
	require("dap").continue()
end

nmap("<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
nmap("<F5>", continue)
nmap("<F11>", "<cmd>lua require'dap'.step_into()<cr>")
nmap("<F10>", "<cmd>lua require'dap'.step_over()<cr>")
nmap("<F12>", "<cmd>lua require'dap'.step_out()<cr>")
nmap("<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
nmap("<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
nmap("<leader>du", "<cmd>lua require'dapui'.toggle()<cr>")
nmap("<leader>dt", "<cmd>lua require'dap'.terminate()<cr>")

-- Adapters
-- Node
dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
}

-- Chrome
dap.adapters.chrome = {
	type = "executable",
	command = "node",
	args = { vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
}

--  Go
dap.adapters.go = {
	type = "executable",
	command = "node",
	args = { vim.fn.stdpath("data") .. "/mason/packages/go-debug-adapter/extension/dist/debugAdapter.js" },
}

-- C/C++/Rust
dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
}

-- Python\
dap.adapters.python = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
	args = { "-m", "debugpy.adapter" },
}

--Configurations
-- JS/TS/Node/React
dap.configurations.javascript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
}

dap.configurations.javascript = {
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}

dap.configurations.javascriptreact = {
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}

dap.configurations.typescriptreact = {
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}

-- Go
dap.configurations.go = {
	{
		type = "go",
		name = "Debug",
		request = "launch",
		showLog = false,
		program = "${file}",
		dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
	},
}

-- C/C++
dap.configurations.cpp = {
	{
		name = "Launch",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = true,
	},
	{
		name = "Attach to gdbserver :1234",
		type = "cppdbg",
		request = "launch",
		MIMode = "gdb",
		miDebuggerServerAddress = "localhost:1234",
		miDebuggerPath = "/usr/bin/gdb",
		cwd = "${workspaceFolder}",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- Python
dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = function()
			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
				return cwd .. "/venv/bin/python"
			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			else
				return "/usr/bin/python"
			end
		end,
	},
}

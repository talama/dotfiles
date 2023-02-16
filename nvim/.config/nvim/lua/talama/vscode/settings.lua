local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

-- Function for normal mode
local function nmap(shortcut, command)
	keymap("n", shortcut, command, opts)
end

local function xmap(shortcut, command)
	keymap("x", shortcut, command, opts)
end

-- Better window navigation
nmap("<C-j>", "<cmd> call VSCodeNotify('workbench.action.navigateDown') <CR>")
xmap("<C-j>", "<cmd> call VSCodeNotify('workbench.action.navigateDown') <CR>")
nmap("<C-k>", "<cmd> call VSCodeNotify('workbench.action.navigateUp') <CR>")
xmap("<C-k>", "<cmd> call VSCodeNotify('workbench.action.navigateUp') <CR>")
nmap("<C-h>", "<cmd> call VSCodeNotify('workbench.action.navigateLeft') <CR>")
xmap("<C-h>", "<cmd> call VSCodeNotify('workbench.action.navigateLeft') <CR>")
nmap("<C-l>", "<cmd> call VSCodeNotify('workbench.action.navigateRight') <CR>")
xmap("<C-l>", "<cmd> call VSCodeNotify('workbench.action.navigateRight') <CR>")

-- Window resize
nmap("<C-Left>", "<cmd> call VSCodeNotify('workbench.action.decreaseViewWidth') <CR>")
xmap("<C-Left>", "<cmd> call VSCodeNotify('workbench.action.decreaseViewWidth') <CR>")
nmap("<C-Right>", "<cmd> call VSCodeNotify('workbench.action.increaseViewWidth') <CR>")
xmap("<C-Right>", "<cmd> call VSCodeNotify('workbench.action.increaseViewWidth') <CR>")
nmap("<C-Up>", "<cmd> call VSCodeNotify('workbench.action.increaseViewHeight') <CR>")
xmap("<C-Up>", "<cmd> call VSCodeNotify('workbench.action.increaseViewHeight') <CR>")
nmap("<C-Down>", "<cmd> call VSCodeNotify('workbench.action.decreaseViewHeight') <CR>")
xmap("<C-Down>", "<cmd> call VSCodeNotify('workbench.action.decreaseViewHeight') <CR>")

-- Window Split
nmap("vv", "<cmd> call VSCodeNotify('workbench.action.splitEditor') <CR>")
xmap("vv", "<cmd> call VSCodeNotify('workbench.action.splitEditor') <CR>")
nmap("ss", "<cmd> call VSCodeNotify('workbench.action.splitEditorDown') <CR>")
xmap("ss", "<cmd> call VSCodeNotify('workbench.action.splitEditorDown') <CR>")

-- which-key
nmap("<Space>", "<cmd> call VSCodeNotify('whichkey.show') <cr>")
xmap("<Space>", "<cmd> call VSCodeNotify('whichkey.show') <cr>")

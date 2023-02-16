local keymap = vim.keymap.set
-- Silent keymap option
local opts = { noremap = true, silent = true }

-- Function for normal mode
local function nmap(shortcut, command)
	keymap("n", shortcut, command, opts)
end

-- Function for insert mode
local function imap(shortcut, command)
	keymap("i", shortcut, command, opts)
end

-- Functions for visual mode
local function vmap(shortcut, command)
	keymap("v", shortcut, command, opts)
end

local function xmap(shortcut, command)
	keymap("x", shortcut, command, opts)
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- NORMAL MODE ---

-- Current buffer navigation
nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")

-- Save
nmap("<C-s>", "<cmd>w<CR>")

-- No highlight
nmap("<leader>h", "<cmd>nohlsearch<CR>")

-- Don't yank on delete char
nmap("x", '"_x')
nmap("X", '"_X')

-- Increment/Decrement
nmap("+", "<C-a>")
nmap("-", "<C-x>")

-- Select All
nmap("<C-a>", "gg<S-v>G")

-- Yank to clipboard
nmap("<leader>y", '"+y')
nmap("<leader>Y", '"+Y')
vmap("<leader>y", '"+y')

-- Delete to void register
nmap("<leader>d", '"_d')
vmap("<leader>d", '"_d')

--- INSERT MODE ---
-- Go to the beginning and end of the line
imap("<C-b>", "<ESC>^i")
imap("<C-e>", "<END>")

-- Move text up and down
imap("<A-k>", "<Esc>:m .-2<CR>==gi")
imap("<A-j>", "<Esc>:m .+1<CR>==gi")
imap("<A-Up>", "<Esc>:m .-2<CR>==gi")
imap("<A-Down>", "<Esc>:m .+1<CR>==gi")

-- Navigate while in insert mode
imap("<C-h>", "<Left>")
imap("<C-l>", "<Right>")
imap("<C-j>", "<Down>")
imap("<C-k>", "<Up>")

-- Save while in insert mode
imap("<C-s>", "<ESC> :w <CR>")

--- VISUAL MODE ---
-- Better paste
vmap("p", '"_dP')

-- Don't yank on delete char
vmap("x", '"_x')
vmap("X", '"_X')

-- Stay in indent mode
vmap("<", "<gv")
vmap(">", ">gv")

-- Move text up and down
xmap("<A-k>", ":move '<-2<CR>gv-gv")
xmap("<A-j>", ":move '>+1<CR>gv-gv")
xmap("<A-Up>", ":move '<-2<CR>gv-gv")
xmap("<A-Down>", ":move '>+1<CR>gv-gv")

-- paste deleting highlighted word into the void register
xmap("<leader>p", '"_dP')

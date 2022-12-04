local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

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
-- Window navigation
nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

-- Buffer Navigation
nmap("<TAB>", ":bnext<CR>")
nmap("<S-TAB>", ":bprevious<CR>")
nmap("<C-n>", ":enew<CR>")
nmap("<C-q>", ":Bdelete!<CR>")

-- Save
nmap("<C-s>", "<cmd>w<CR>")

-- Easy window split;
nmap("vv", "<C-w>v")
nmap("ss", "<C-w>s")

-- No highlight
nmap("<leader>h", "<cmd>nohlsearch<CR>")

-- Line numbers toggles
nmap("<leader>n", "<cmd>set number!<CR>")
nmap("<leader>rn", "<cmd> set relativenumber! <CR>")

-- Don't yank on delete char
nmap("x", '"_x')
nmap("X", '"_X')

-- Increment/Decrement
nmap("+", "<C-a>")
nmap("-", "<C-x>")

-- Delete a word backwards
nmap("dw", 'vb"_d')

-- Select All
nmap("<C-a>", "gg<S-v>G")

--- INSERT MODE ---
-- Press jk fast to enter
imap("jk", "<ESC>")

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

--- PLUGINS ---
-- Telescope
nmap("<leader>ff", "<cmd> Telescope find_files <CR>")
nmap("<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
nmap("<leader>fw", "<cmd> Telescope live_grep <CR>")
nmap("<leader>fb", "<cmd> Telescope buffers <CR>")
nmap("<leader>fh", "<cmd> Telescope help_tags <CR>")
nmap("<leader>fo", "<cmd> Telescope oldfiles <CR>")
nmap("<leader>fk", "<cmd> Telescope keymaps <CR>")

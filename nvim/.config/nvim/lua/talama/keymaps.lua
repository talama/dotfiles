-- Shorten keymap function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Normal Mode
local function nmap(shortcut, command)
  keymap("n", shortcut, command, opts)
end

-- Insert Mode
local function imap(shortcut, command)
  keymap("i", shortcut, command, opts)
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
-- Go to the beginning and end of the line
imap("<C-b>", "<ESC>^i")
imap("<C-e>", "<END>")

-- Navigate while in insert mode
imap("<C-h>", "<Left>")
imap("<C-l>", "<Right>")
imap("<C-j>", "<Down>")
imap("<C-k>", "<Up>")

-- Save while in insert mode
imap("<C-s>", "<ESC> :w <CR>")

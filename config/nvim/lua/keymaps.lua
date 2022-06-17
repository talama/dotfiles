-- Mapping functions for different modes
function map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, {noremap = true, silent = true})
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end 

function imap(shortcut, command)
  map('i', shortcut, command)
end 

function vmap(shortcut, command)
  map('v', shortcut, command)
end 

function cmap(shortcut, command)
  map('c', shortcut, command)
end 

function tmap(shortcut, command)
  map('t', shortcut, command)
end 

-- Remap leader to space
map('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- clear matches with Ctrl+b
map('', '<C-b>', ':noh<cr>:call clearmatches()<cr>') 

-- Normal mode
-- Better window navigation
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

-- Better buffer navigation
nmap('<TAB>', ':bnext<cr>')
nmap('<S-TAB>', ':bprevious<cr>')
nmap('<S-q>', ':bd!<cr>')  -- close buffer
nmap('<S-b>', ':enew<cr>') -- new buffer

-- Easy window split;
nmap('vv', '<C-w>v')
nmap('ss', '<C-w>s')

-- Resize with arrows
nmap('<C-Up>', ':resize +2<cr>')
nmap('<C-Down>', ':resize -2<cr>')
nmap('<C-Left>', ': vertical resize -2<cr>')
nmap('<C-Right>', ':vertical resize +2<cr>')

-- Move text up and down
nmap('<A-j>', '<Esc>:m .+1<CR>==gi')
nmap('<A-k>', '<Esc>:m .-2<CR>==gi')

nmap('<leader>e', ':Lex 30<cr>')

-- Insert Mode
-- Press jk fast to enter
imap('jk', '<ESC>')

-- Visual Mode
-- Stay in indent mode
vmap('<', '<gv')
vmap('<', '<gv')

-- Terminal Mode
-- ESC to go to normal mode in terminal
tmap('<C-s>', '<C-\\><C-n>')
tmap('<Esc><Esc>', '<C-\\><C-n>')

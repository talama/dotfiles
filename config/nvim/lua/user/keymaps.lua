-- Mapping functions for different modes
local function map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, {noremap = true, silent = true})
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end

 local function imap(shortcut, command)
  map('i', shortcut, command)
end

local function vmap(shortcut, command)
  map('v', shortcut, command)
end

local function xmap(shortcut, command)
  map('x', shortcut, command)
end

 local function tmap(shortcut, command)
  map('t', shortcut, command)
end

-- Remap leader to space
map('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- clear matches with Ctrl+b
map('', '<leader>h', ':noh<cr>:call clearmatches()<cr>')

-- Normal mode
-- Reload configuration
nmap('<leader>s', '<cmd> lua ReloadConfig()<cr>')

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

nmap('<leader>e', ':Lex 30<cr>')

-- Insert Mode
-- Press jk fast to enter
imap('jk', '<ESC>')

-- Visual Mode
-- Move text up and down
vmap("<A-j>", ":m .+1<CR>==gv")
vmap("<A-k>", ":m .-2<CR>==gv")
-- Better paste
vmap("p", '"_dP')
-- Stay in indent mode
vmap('<', '<gv')
vmap('<', '<gv')

-- Terminal Mode
-- ESC to go to normal mode in terminal
tmap('<C-s>', '<C-\\><C-n>')
tmap('<Esc><Esc>', '<C-\\><C-n>')

-- PLUGINS
-- Telescope
-- find
nmap('<leader>ff', ':Telescope find_files <CR>')
nmap('<leader>fa', ':Telescope find_files follow=true no_ignore=true hidden=true <CR>')
nmap('<leader>fw', ':Telescope live_grep <CR>')
nmap('<leader>fb', ':Telescope buffers <CR>')
nmap('<leader>fh', ':Telescope help_tags <CR>')
nmap('<leader>fo', ':Telescope oldfiles <CR>')
nmap('<leader>fk', ':Telescope keymaps<CR>')
-- git
nmap('<leader>cm', ':Telescope git_commits<CR>')
nmap('<leader>gt', ':Telescope git_status<CR>')
-- Comments
nmap('<leader>/', '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>')
nmap('<A-/>', '<cmd>lua require("Comment.api").toggle_current_blockwise()<CR>')
xmap('<leader>/', '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

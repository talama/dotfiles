
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

-- clear matches
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

-- Insert Mode
-- Press jk fast to enter
imap('jk', '<ESC>')

-- Visual Mode
-- Move text up and down
vmap('<A-j>', ':m .+1<CR>==gv')
vmap('<A-k>', ':m .-2<CR>==gv')

-- Better paste
vmap('p', '_dP')

-- Stay in indent mode
vmap('<', '<gv')
vmap('<', '<gv')

-- Terminal Mode
-- ESC to go to normal mode in terminal
tmap('<C-s>', '<C-\\><C-n>')
tmap('<Esc><Esc>', '<C-\\><C-n>')

-- PLUGINS
-- LSP
nmap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
nmap("gd", '<cmd>lua vim.lsp.buf.definition()<CR>')
nmap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
nmap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
nmap('gl', '<cmd>lua vim.diagnostic.open_float()<CR>')
nmap('<leader>lf', '<cmd>lua vim.lsp.buf.format()<CR>')
nmap('<leader>li', '<cmd>LspInfo<cr>')
nmap('<leader>lI', '<cmd>LspInstallInfo<cr>')
nmap('<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>')
nmap('<leader>lj"', '<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>"')
nmap('<leader>lk', '<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>')
nmap('<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>')
nmap('<leader>ld', '<cmd>lua vim.diagnostic.open_float({ border = "rounded", max_width = 100 })<CR>')

-- Telescope
nmap('<leader>ff', ':Telescope find_files<CR>')
nmap('<leader>ft', ':Telescope live_grep<CR>')
nmap('<leader>fp', ':Telescope projects<CR>')
nmap('<leader>fb', ':Telescope buffers<CR>')

-- Trouble
nmap('<leader>t', ':TroubleToggle<cr>')

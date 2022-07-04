
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
nmap('<leader>s', '<cmd>lua ReloadConfig()<cr>')

-- Better window navigation
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

-- H to move to the first non-blank charachter of the line
nmap('H', '^')

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

-- Move between barbar buffers
nmap('<Space>1', ':BufferGoto 1<CR>')
nmap('<Space>2', ':BufferGoto 2<CR>')
nmap('<Space>3', ':BufferGoto 3<CR>')
nmap('<Space>4', ':BufferGoto 4<CR>')
nmap('<Space>5', ':BufferGoto 5<CR>')
nmap('<Space>6', ':BufferGoto 6<CR>')
nmap('<Space>7', ':BufferGoto 7<CR>')
nmap('<Space>8', ':BufferGoto 8<CR>')
nmap('<Space>9', ':BufferGoto 9<CR>')
nmap('<A-1>', ':BufferGoto 1<CR>')
nmap('<A-2>', ':BufferGoto 2<CR>')
nmap('<A-3>', ':BufferGoto 3<CR>')
nmap('<A-4>', ':BufferGoto 4<CR>')
nmap('<A-5>', ':BufferGoto 5<CR>')
nmap('<A-6>', ':BufferGoto 6<CR>')
nmap('<A-7>', ':BufferGoto 7<CR>')
nmap('<A-8>', ':BufferGoto 8<CR>')
nmap('<A-9>', ':BufferGoto 9<CR>')

-- Don't yank on delete char
nmap('x', '"_x')
nmap('X', '"_X')
vmap('x', '"_x')
vmap('X', '"_X')

-- Quickfix
nmap('<leader>,', ':cp<CR>')
nmap('<leader>.', ':cn<CR>')

-- Insert Mode
-- Press jk fast to enter
imap('jk', '<ESC>')

-- Save file with CTRL-S
nmap('<C-s>', ':w<CR>')
imap('<C-s>', '<ESC> :w<CR>')

-- Visual Mode
-- Move text up and down
xmap('K', ":move '<-2<CR>gv-gv")
xmap('J', ":move '>+1<CR>gv-gv")

-- Don't yank on visual paste
vmap('p', '"_dP')

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



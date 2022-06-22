-- Basic settings
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.o.backspace = "indent,eol,start" -- backspace works on every char in insert mode
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.o.startofline = true
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.mouse = "a" -- allow mouse use
vim.opt.conceallevel = 0
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.undofile = true   -- enable persistent undo
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")
relativenumber = false -- set relative numbered lines

-- Waiting time
vim.opt.timeoutlen = 1000  
vim.opt.updatetime = 300

-- Display
vim.o.showmatch  = true -- show matching brackets
vim.o.scrolloff = 8 
vim.opt.sidescrolloff = 8
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.o.synmaxcol = 300 -- stop syntax highlight after x lines for performance
vim.o.laststatus = 2 -- always show status line
vim.opt.cursorline = true -- highlight the current line
vim.o.list = false -- do not display white characters

vim.o.foldenable = false
vim.o.foldlevel = 4 -- limit folding to 4 levels
vim.o.foldmethod = 'syntax' -- use language syntax to generate folds
vim.o.wrap = false --do not wrap lines even if very long
vim.o.showbreak= '↪' -- character to show when line is broken
vim.o.background = 'dark'
vim.opt.termguicolors = true

-- Sidebar
vim.o.number = true -- line number on the left
vim.o.numberwidth = 4 -- always reserve 3 spaces for line number
vim.o.modelines = 0
vim.o.showcmd = true -- display command in bottom bar

-- Search
vim.o.incsearch = true -- starts searching as soon as typing, without enter needed
vim.o.ignorecase = true -- ignore letter case when searching
vim.o.smartcase = true -- case insentive unless capitals used in search

vim.o.matchtime = 2 -- delay before showing matching paren

-- Indentation
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 2 -- 1 tab = 2 spaces
vim.o.shiftwidth = 2 -- indentation rule
vim.o.formatoptions = 'qnj1' -- q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word
vim.o.expandtab = true -- expand tab to spaces
vim.opt.showtabline = 2 -- always show tabs

-- Backup files
vim.o.backup = false --  do not use backup files
vim.o.swapfile = false -- do not use swap files



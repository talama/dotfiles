local function map(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- map esc to kk
map("i", "jj", "<Esc>")
map("i", "jk", "<Esc>:write<CR>")
map("i", "<C-c>", "<Esc>")

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Select All
-- map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Better up/down
map({ "n", "x" }, "j", "v:count == 2 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 2 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 2 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 2 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move line/paragraph
map("n", "H", "^", { desc = "Beginning of line" })
map("n", "L", "$", { desc = "End of line" })
map("n", "J", "}", { desc = "Paragraph Up" })
map("n", "K", "{", { desc = "Paragraph Down" })

-- Change split orientation
map("n", "<leader>tv", "<C-w>t<C-w>K")
map("n", "<leader>th", "<C-w>t<C-w>H")

-- Move to window using <ctrl> // Disabled because of tmux navigator
-- map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
-- map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
-- map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
-- map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +4<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize 0<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize 0<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +4<cr>", { desc = "Increase window width" })

-- Go to the beginning and end of the line
map({ "n", "i" }, "<C-b>", "<ESC>^i")
map({ "n", "i" }, "<C-e>", "<END>")

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Buffers
map("n", "<C-n>", ":enew<CR>", { desc = "New Buffer" })
map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
	Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })

-- Current buffer navigation
map("n", "<C-u>", "<C-u>zz", { desc = "Move Up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Move Down" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

--Easy window split
map("n", "<leader>wh", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>wv", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Close current split", remap = true })
map("n", "<leader>we", "<C-W>=", { desc = "Make splits equal", remap = true })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- comments
map({ "n", "v" }, "<leader>/", "gcc", { remap = true, desc = "Comment line" })
map({ "n", "v" }, "<leader>.", "gcb", { remap = true, desc = "Comment block" })
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- Better paste / yank
map({ "v", "x" }, "<leader>p", [["_dP]])

map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

map({ "n", "v" }, "<leader>d", [["_d]])

-- Search word
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- Replace word
map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word in file" })

-- Increment/Decrement numbers
map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

map("n", "<leader>ei", "<cmd>lua require('emoji').insert()<cr>", { desc = "insert emoj" })

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

-- new buffer
map("n", "<C-n>", ":enew<CR>", { desc = "New Buffer" })

-- Select All
-- map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 2 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 2 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 2 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 2 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

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
map({ "n", "v" }, "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map({ "n", "v" }, "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })

-- Tabs
map("n", "<TAB>", ":bnext<CR>", { desc = "Next Buffer" })
map("n", "<S-TAB>", ":bprevious<CR>", { desc = "Previous Buffer" })
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })

-- Current buffer navigation
map("n", "<C-u>", "<C-u>zz", { desc = "Move Up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Move Down" })

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

-- Zen mode
map("n", "<leader>zz", function()
	require("zen-mode").toggle()
end, { desc = "Toggle zen-mode" })

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

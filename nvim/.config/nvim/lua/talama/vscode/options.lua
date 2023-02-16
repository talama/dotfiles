-- disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local options = {
	autoindent = true, -- Good autoindent
	backup = false, --- no backup file
	clipboard = "unnamed,unnamedplus", --- Copy-paste between vim and everything else
	conceallevel = 0, --- Show `` in markdown files
	emoji = false, --- Fix emoji display
	encoding = "utf-8", --- The encoding displayed
	fileencoding = "utf-8", --- The encoding written to file
	fillchars = { eob = " " }, -- Disable `~` on nonexistent lines
	foldlevelstart = 99, --- Expand all folds by default
	foldtext = "CustomFold()", --- Emit custom function for foldtext
	ignorecase = true, --- Needed for smartcase
	lazyredraw = true, --- Makes macros faster & prevent errors in complicated mappings
	scrolloff = 8, --- Always keep space when scrolling to bottom/top edge
	showtabline = 2, --- Always show tabs
	sidescrolloff = 8, --- Always keep space when scrolling to the side
	swapfile = false, --- Swap not needed
	tabstop = 2, --- Insert 2 spaces for a tab
	termguicolors = true, --- Correct terminal colors
	timeoutlen = 200, --- Faster completion (cannot be lower than 200 because then commenting doesn't work)
	undofile = true, --- Sets undo to file
	updatetime = 300, --- Faster completion
	wildignore = "*node_modules/**", --- Don't search inside Node.js modules
	wrap = false, --- Display long lines as just one line
	writebackup = false, --- Not needed
}

vim.opt.whichwrap:append("<,>,[,],h,l") -- keys allowed to move to the previous/next line when the beginning/end of line is reached
vim.opt.iskeyword:append("-") -- treats words with `-` as single words

for k, v in pairs(options) do
	vim.opt[k] = v
end

local options = {
	autoindent = true,				                -- Good autoindent
	backup = false, --- no backup file
	clipboard = "unnamed,unnamedplus", --- Copy-paste between vim and everything else
	cmdheight = 2, --- Give more space for displaying messages
	completeopt = { "menuone", "noselect" }, --- Better autocompletion
	conceallevel = 0, --- Show `` in markdown files
	cursorline = true, --- Highlight of current line
	emoji = false, --- Fix emoji display
	encoding = "utf-8", --- The encoding displayed
	errorbells = false, --- Disables sound effect for errors
	expandtab = true, --- Use spaces instead of tabs
  fileencoding = "utf-8", --- The encoding written to file
	fillchars = { eob = " " }, -- Disable `~` on nonexistent lines
	foldlevelstart = 99, --- Expand all folds by default
	foldtext = "CustomFold()", --- Emit custom function for foldtext
	ignorecase = true, --- Needed for smartcase
	incsearch = true, --- Start searching before pressing enter
	laststatus = 3, --- Have a global statusline at the bottom instead of one for each window
	lazyredraw = true, --- Makes macros faster & prevent errors in complicated mappings
	mouse = "a", --- Enable mouse
	number = true, --- Shows current line number
	pumheight = 10, --- Max num of items in completion menu
	relativenumber = true, --- Enables relative number
  scrolloff = 8, --- Always keep space when scrolling to bottom/top edge
	shiftwidth = 2, --- The number of spaces inserted for each indentation 
	showmode = false, --- Don't show things like -- INSERT -- anymore
	showtabline = 2, --- Always show tabs
	sidescrolloff = 8, --- Always keep space when scrolling to the side
	signcolumn = "yes:1", --- Add extra sign column next to line number
	smartcase = true, --- Handle case in search
	smartindent = true, --- Makes indenting smart
	smarttab = true, --- Makes tabbing smarter will realize you have 2 vs 4
	softtabstop = 2, --- Insert 2 spaces for a tab
	splitbelow = true, -- Splitting a new window below the current one
	splitright = true, --- Vertical splits will automatically be to the right
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

vim.opt.whichwrap:append("<,>,[,],h,l")         -- keys allowed to move to the previous/next line when the beginning/end of line is reached
vim.opt.iskeyword:append("-")                   -- treats words with `-` as single words

for k, v in pairs(options) do
	vim.opt[k] = v
end

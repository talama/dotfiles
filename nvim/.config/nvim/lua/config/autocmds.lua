-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Format on save Enable/Disable
--------------------------------
vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

-- General settings:
--------------------

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	group = "YankHighlight",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = "1000" })
	end,
})

-- Remove whitespace on save
autocmd("BufWritePre", {
	pattern = "",
	command = ":%s/\\s\\+$//e",
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
	pattern = "",
	command = "set fo-=c fo-=r fo-=o",
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime", { clear = true }),
	command = "checktime",
})

-- resize splits if window got resized
augroup("resize_splits", { clear = true })
autocmd("VimResized", {
	group = "resize_splits",
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Settings for filetypes:
--------------------------

-- Disable line length marker
augroup("setLineLength", { clear = true })
autocmd("Filetype", {
	group = "setLineLength",
	pattern = { "text", "markdown", "html", "xhtml", "javascript", "typescript" },
	command = "setlocal cc=0",
})

-- close some filetypes with <q>
augroup("close_with_q", { clear = true })
autocmd("FileType", {
	group = "close_with_q",
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Terminal settings:
---------------------

-- Open a Terminal on the right tab
autocmd("CmdlineEnter", {
	command = "command! Term :botright vsplit term://$SHELL",
})

-- Enter insert mode when switching to terminal
autocmd("TermOpen", {
	command = "setlocal listchars= nonumber norelativenumber nocursorline",
})

autocmd("TermOpen", {
	pattern = "",
	command = "startinsert",
})

-- Close terminal buffer on process exit
autocmd("BufLeave", {
	pattern = "term://*",
	command = "stopinsert",
})

-- Gotmpl
-- Autocmd to set filetype from gohtmltmpl to gotmpl
autocmd("FileType", {
	pattern = "gohtmltmpl",
	callback = function()
		vim.bo.filetype = "gotmpl"
	end,
})

vim.api.nvim_create_augroup("filetypedetect", { clear = true })

-- Check if html file contains gotmpl syntax
local function detect_go_html_tmpl()
	if vim.fn.expand("%:e") == "html" and vim.fn.search("{{") ~= 0 then
		vim.bo.filetype = "gotmpl"
	end
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*",
	callback = detect_go_html_tmpl,
	group = "filetypedetect",
})

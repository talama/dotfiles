local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return require("packer").startup(function(use)
	--  My plugins here
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Needed to load first
	-- Optimiser
	use({ "lewis6991/impatient.nvim" })

	-- Lua functions
	use({ "nvim-lua/plenary.nvim" })

	-- Icons
	use({ "kyazdani42/nvim-web-devicons" })

	-- Start screen
	use({ "goolord/alpha-nvim", config = "require('talama.plugins.alpha')" })

	-- Cursorhold fix
	use({ "antoinemadec/FixCursorHold.nvim", event = { "BufRead", "BufNewFile" } })

	-- Colorschemes
	use({ "ful1e5/onedark.nvim" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = "require('talama.plugins.treesitter')",
		run = ":TSUpdate",
	})
	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = { "nvim-treesitter" } })

	-- Telescope fuzzy finder
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({
		"nvim-telescope/telescope.nvim",
		config = "require('talama.plugins.telescope')",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim" },
		},
	})
	use({ "nvim-telescope/telescope-ui-select.nvim" })

	--- Nvim-tree
	use({ "kyazdani42/nvim-tree.lua", config = "require('talama.plugins.tree')" })

	-- LSP manager
	use({ "williamboman/nvim-lsp-installer", after = "nvim-lspconfig" })

	-- Built-in LSP
	use({ "neovim/nvim-lspconfig", event = "VimEnter" })

	-- Completion engine
	use({ "hrsh7th/nvim-cmp", event = "InsertEnter", config = "require('talama.plugins.cmp')" })

	-- Lua completion source
	use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })

	-- Lsp completion source
	use({ "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" })

	-- Buffer completion source
	use({ "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" })

	-- Path completion source
	use({ "hrsh7th/cmp-path", after = "cmp-buffer" })

	-- Command line completion source
	use({ "hrsh7th/cmp-cmdline", after = "cmp-path" })

	-- Formatting and linting
	use({ "jose-elias-alvarez/null-ls.nvim", config = "require('talama.lsp.null-ls')" })

	-- adds vscode-like pictograms to neovim built-in lsp
	use({ "onsails/lspkind-nvim" })

	-- Diagnostic
	use({ "folke/lsp-trouble.nvim", config = "require('talama.plugins.trouble')" })

	-- Popup API
	use({ "nvim-lua/popup.nvim" })

	-- Better buffer closing
	use({ "famiu/bufdelete.nvim", cmd = { "Bdelete", "Bwipeout" } })

	-- Terminal
	use({ "akinsho/nvim-toggleterm.lua", branch = "main", config = "require('talama.plugins.toggleterm')" })

	-- Highlight
	use({ "RRethy/vim-illuminate", config = "require('talama.plugins.illuminate')" })

	-- Commenting
	use({ "numToStr/Comment.nvim", config = "require('talama.plugins.comment')" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })

	-- Buffer Bar
	use({
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = "require('talama.plugins.barbar')",
	})

	-- Notification Enhancer
	use({ "rcarriga/nvim-notify" })

	-- Lua line
	use({ "nvim-lualine/lualine.nvim", config = "require('talama.plugins.lualine')" })

	-- Project manager for telescope
	use({ "ahmedkhalf/project.nvim", config = "require('talama.plugins.project')" })

	-- Autopairs
	use({
		"windwp/nvim-autopairs",
		after = { "nvim-treesitter", "nvim-cmp" },
		config = "require('talama.plugins.autopairs')",
	})

	-- Autoclose tags
	use({ "windwp/nvim-ts-autotag", after = { "nvim-treesitter" } })

	-- Parenthesis highlighting
	use({ "p00f/nvim-ts-rainbow", after = { "nvim-treesitter" } })

	-- Indentation
	use({ "lukas-reineke/indent-blankline.nvim", config = "require('talama.plugins.indent')" })

	-- Display colors
	use({ "NvChad/nvim-colorizer.lua", config = "require('talama.plugins.colorizer')" })

	-- -- Snippet completion source
	use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })

	-- Snippets collection
	use({ "rafamadriz/friendly-snippets" })

	-- Snippets engine
	use({ "L3MON4D3/LuaSnip", requires = { "rafamadriz/friendly-snippets" }, after = "cmp_luasnip" })

	-- Session manager
	use({
		"Shatur/neovim-session-manager",
		cmd = "SessionManager",
		event = "BufWritePost",
		config = "require('talama.plugins.session_manager')",
	})

	-- Gitsigns
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = "require('talama.plugins.git.signs')",
		event = "BufRead",
	})
	use({ "sindrets/diffview.nvim", config = "require('talama.plugins.git.diffview')" })
	use({ "akinsho/git-conflict.nvim", config = "require('talama.plugins.git.conflict')" })

	-- lazygit
	use({ "kdheepak/lazygit.nvim" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

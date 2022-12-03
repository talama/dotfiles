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
	git = {
		clone_timeout = 300, -- Timeout, in seconds, for git clones
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- PLUGINS
	-- Packer can manage itself
	use({ "wbthomason/packer.nvim" })

	-- Impatient to optimize nvim load time
	use({ "lewis6991/impatient.nvim" })

	-- Lua functions
	use({ "nvim-lua/plenary.nvim" })

	-- Icons
	use({ "kyazdani42/nvim-web-devicons" })

	-- Start screen
	use({ "goolord/alpha-nvim", config = "require('talama.plugins.alpha')" })

	-- Colorschemes
	use({ "navarasu/onedark.nvim" })
	use({ "olimorris/onedarkpro.nvim" })

	-- Lualine
	use({
		"nvim-lualine/lualine.nvim",
		config = "require('talama.plugins.lualine')",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Notify
	use({ "rcarriga/nvim-notify" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = "require('talama.plugins.treesitter')",
		run = ":TSUpdate",
	})

	-- Telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope-ui-select.nvim" })
	use({ "nvim-lua/popup.nvim" })
	use({
		"nvim-telescope/telescope.nvim",
		config = "require('talama.plugins.telescope')",
		requires = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope-fzf-native.nvim" } },
	})

	-- LSP
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })

	-- CMP
	use({ "hrsh7th/nvim-cmp", config = "require('talama.plugins.cmp') " })
	use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" })
	use({ "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-path", after = "cmp-buffer" })
	use({ "hrsh7th/cmp-cmdline", after = "cmp-path" })
	use({ "hrsh7th/cmp-calc", after = "cmp-cmdline" })

	-- Snippets
	use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
	-- Snippets collection
	use({ "rafamadriz/friendly-snippets" })
	-- Snippets engine
	use({ "L3MON4D3/LuaSnip", requires = { "rafamadriz/friendly-snippets" }, after = "cmp_luasnip" })

	-- LSP Addons
	use({ "jose-elias-alvarez/typescript.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim", config = "require('talama.plugins.lsp.null-ls')" }) -- Linting / formatting
	use({ "onsails/lspkind-nvim" }) -- Adds vscode-like pictograms to neovim built-in lsp
	use({ "folke/lsp-trouble.nvim", config = "require('talama.plugins.trouble')" }) -- Diagnostic

	--- Nvim-tree
	use({ "kyazdani42/nvim-tree.lua", config = "require('talama.plugins.tree')" })

	-- Buffer Bar
	use({
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = "require('talama.plugins.barbar')",
	})

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

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

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
	use({ "olimorris/onedarkpro.nvim" })
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- Telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope-ui-select.nvim" })
	use({ "nvim-lua/popup.nvim" })
	use({
		"nvim-telescope/telescope.nvim",
		config = "require('talama.plugins.telescope')",
		requires = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope-fzf-native.nvim" } },
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = "require('talama.plugins.treesitter')",
		run = ":TSUpdate",
	})
	use({ "nvim-treesitter/playground" })
	-- Additional text objects via treesitter
	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })
	-- Highlight parameters inside function body
	use({
		"m-demare/hlargs.nvim",
		config = "require('talama.plugins.hlargs')",
		requires = { "nvim-treesitter/nvim-treesitter" },
	})

	-- LSP
	-- lsp-zero
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-cmdline" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})
	-- Null-ls for linting/formatting
	use({ "jose-elias-alvarez/null-ls.nvim", config = "require('talama.plugins.lsp.null-ls')" })
	use({ "folke/lsp-trouble.nvim", config = "require('talama.plugins.trouble')" }) -- Diagnostic

	-- Lualine
	use({
		"nvim-lualine/lualine.nvim",
		config = "require('talama.plugins.lualine')",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Highlight other use of word under the cursor.
	use({ "RRethy/vim-illuminate", config = "require('talama.plugins.illuminate')" })

	-- Autopairs
	use({
		"windwp/nvim-autopairs",
		after = { "nvim-treesitter", "nvim-cmp" },
		config = "require('talama.plugins.autopairs')",
	})

	-- Autoclose tags
	use({ "windwp/nvim-ts-autotag", after = { "nvim-treesitter" } })

	-- Indentation
	use({ "lukas-reineke/indent-blankline.nvim", config = "require('talama.plugins.indent')" })

	-- Terminal
	use({ "akinsho/nvim-toggleterm.lua", branch = "main", config = "require('talama.plugins.toggleterm')" })

	-- Bufferline
	use({
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		requires = "nvim-tree/nvim-web-devicons",
		config = "require('talama.plugins.bufferline')",
	})

	--- Nvim-tree
	use({ "kyazdani42/nvim-tree.lua", config = "require('talama.plugins.nvim-tree')" })

	-- Better buffer closing
	use({ "famiu/bufdelete.nvim", cmd = { "Bdelete", "Bwipeout" } })

	-- Comments
	use({ "numToStr/Comment.nvim", config = "require('talama.plugins.comment')" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

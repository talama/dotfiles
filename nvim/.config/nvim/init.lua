vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Auto-install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
	print("Installing lazy.nvim....")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("config.options"),
	require("config.keymaps"),
	require("config.autocmds"),
	install = {
		colorscheme = { "catppuccin" },
	},
	checker = {
		enabled = true,
		notify = true,
	},
	change_detection = {
		notify = true,
	},
	spec = {
		{
			"catppuccin/nvim",
			lazy = false,
			priority = 1000,
		},
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				require("tokyonight").setup()
				-- vim.cmd.colorscheme("tokyonight")
			end,
		},
		-- Icons
		{ "kyazdani42/nvim-web-devicons", lazy = true },

		-- Indent line
		{ "lukas-reineke/indent-blankline.nvim" },

		-- Autopair
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		},

		-- Telescope
		{
			"nvim-telescope/telescope.nvim",
			cmd = "Telescope",
			version = false,
			dependencies = {
				{ "nvim-lua/plenary.nvim" },
				{
					"nvim-telescope/telescope-fzf-native.nvim",
					build = "make",
					config = function()
						require("telescope").load_extension("fzf")
					end,
				},
			},
		},

		-- Treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			dependencies = {
				"JoosepAlviste/nvim-ts-context-commentstring",
			},
		},

		-- LSP
		{
			"VonHeikemen/lsp-zero.nvim",
			branch = "v2.x",
			dependencies = {
				{ "neovim/nvim-lspconfig" },
				{ "williamboman/mason.nvim" },
				{ "williamboman/mason-lspconfig.nvim" },

				{ "hrsh7th/nvim-cmp" },
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "L3MON4D3/LuaSnip" },
			},
		},

		-- Null-ls
		{
			"jose-elias-alvarez/null-ls.nvim",
		},

		-- Autocomplete
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-cmdline",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
			},
		},

		-- tpope
		{ "tpope/vim-surround" },
		{ "tpope/vim-fugitive" },

		-- autotag
		{ "windwp/nvim-ts-autotag" },
		-- Plugins
		{ import = "plugins.core" },
		{ import = "plugins.extra" },
		{ import = "plugins.extra.lang" },
	},
})
vim.cmd.colorscheme("catppuccin-macchiato")
vim.opt.termguicolors = true

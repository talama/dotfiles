vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

-- VsCode setup
if vim.g.vscode then
	lazy.setup({
		-- disable the colorscheme
		colorscheme = function() end,
		checker = {
			enabled = false,
		},
		spec = {
			{ import = "plugins.common" },
			{
				"nvim-treesitter/nvim-treesitter",
				opts = { highlight = { enable = false } },
			},
			{ "tpope/vim-repeat", event = "VeryLazy" },
			{ "tpope/vim-surround" },
			{ "nvim-lua/plenary.nvim" },
		},
	})
else
	-- Nvim setup
	lazy.setup({
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
			-- Colorscheme:
			-- The colorscheme should be available when starting Neovim.
			{
				"catppuccin/nvim",
				lazy = false,
				priority = 1000,
				config = function()
					require("catppuccin").setup()
					vim.cmd([[colorscheme catppuccin-macchiato]])
				end,
			},

			-- Plenary
			{ "nvim-lua/plenary.nvim" },

			-- Icons
			{ "kyazdani42/nvim-web-devicons", lazy = true },

			-- tpope
			{ "tpope/vim-surround" },
			{ "tpope/vim-repeat", event = "VeryLazy" },

			-- tmux navigator
			{ "christoomey/vim-tmux-navigator" },

      -- nvim-nio
      { "nvim-neotest/nvim-nio" },

			-- Plugins
			{ import = "plugins.core" },
			{ import = "plugins.common" },
			{ import = "plugins.extra" },
			{ import = "plugins.lang" },
		},
	})
end

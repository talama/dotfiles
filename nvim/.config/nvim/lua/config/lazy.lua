vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
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
			{ import = "plugins.shared" },
			{
				"nvim-treesitter/nvim-treesitter",
				opts = { highlight = { enable = false } },
			},
			{ "tpope/vim-repeat", event = "VeryLazy" },
			{ "nvim-lua/plenary.nvim" },
		},
	})
else
	-- Nvim setup
	lazy.setup({
		spec = {
			-- Plenary
			{ "nvim-lua/plenary.nvim" },

			-- Icons
			{ "kyazdani42/nvim-web-devicons", lazy = true },

			-- tpope
			{ "tpope/vim-repeat", event = "VeryLazy" },

			-- tmux navigator
			{ "christoomey/vim-tmux-navigator" },

			-- import your plugins
			{ import = "plugins" },
			{ import = "plugins.shared" },
			{ import = "plugins.lang" },
			{ import = "plugins.ui" },
		},
		-- Configure any other settings here. See the documentation for more details.
		-- colorscheme that will be used when installing plugins.
		install = { colorscheme = { "catppuccin" } },
		-- automatically check for plugin updates
		checker = {
			enabled = true,
			notify = true,
		},
		-- automatically check/notify for config file changes and reload the ui
		change_detection = {
			enabled = true,
			notify = true,
		},
		defaults = {
			lazy = false,
			version = false,
		},
		ui = {
			border = "none",
		},
		performance = {
			cache = {
				enabled = true,
			},
		},
	})
end

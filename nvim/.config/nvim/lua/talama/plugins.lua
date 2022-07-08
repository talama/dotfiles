local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return require('packer').startup(function(use)
  --  My plugins here
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Needed to load first
  use { 'lewis6991/impatient.nvim' }
  -- use { 'nathom/filetype.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'goolord/alpha-nvim', config = "require('talama.plugins.alpha')" }
  use("antoinemadec/FixCursorHold.nvim")

  -- Colorschemes
  use { 'ful1e5/onedark.nvim' }

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', config = "require('talama.plugins.treesitter')" }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', after = { 'nvim-treesitter' } }

  -- Telescope
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope.nvim',
    config = "require('talama.plugins.telescope')",
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim' },
      { 'nvim-telescope/telescope-media-files.nvim', },
    },
  }
  use("nvim-telescope/telescope-media-files.nvim")

  --- Nvim-tree
  use { 'kyazdani42/nvim-tree.lua', config = "require('talama.plugins.tree')" }

  -- LSP Base
  use { 'williamboman/nvim-lsp-installer' }
  use { 'neovim/nvim-lspconfig' }

  -- LSP Cmp
  use { 'hrsh7th/nvim-cmp', event = 'InsertEnter', config = "require('talama.plugins.cmp')" }
  use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp', after = 'cmp-nvim-lua' }
  use { 'hrsh7th/cmp-buffer', after = 'cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-path', after = 'cmp-buffer' }
  use { 'hrsh7th/cmp-cmdline', after = 'cmp-path' }

  -- LSP Addons
  use { 'akinsho/nvim-toggleterm.lua', branch = 'main', config = "require('talama.plugins.toggleterm')" }
  use { 'jose-elias-alvarez/null-ls.nvim', config = "require('talama.lsp.null-ls')" }
  use { 'RRethy/vim-illuminate', config = "require('talama.plugins.illuminate')" }
  use { 'onsails/lspkind-nvim' } -- adds vscode-like pictograms to neovim built-in lsp
  use { 'folke/lsp-trouble.nvim', config = "require('talama.plugins.trouble')" }
  use { 'nvim-lua/popup.nvim' }

  -- General
  use { 'numToStr/Comment.nvim', config = "require('talama.plugins.comment')" }
  use { 'JoosepAlviste/nvim-ts-context-commentstring' }
  use { 'romgrk/barbar.nvim', requires = { 'kyazdani42/nvim-web-devicons' }, config = "require('talama.plugins.barbar')" }
  use { 'rcarriga/nvim-notify' }
  use { "nvim-lualine/lualine.nvim", config = "require('talama.plugins.lualine')" }

  -- Language and syntax
  use { 'windwp/nvim-autopairs', after = { 'nvim-treesitter', 'nvim-cmp' },
    config = "require('talama.plugins.autopairs')" }
  use { 'p00f/nvim-ts-rainbow', after = { 'nvim-treesitter' } }
  use { 'lukas-reineke/indent-blankline.nvim', config = "require('talama.plugins.indent')" }
  use { 'NvChad/nvim-colorizer.lua', config = "require('talama.plugins.colorizer')" }

  -- Snippets
  use { 'saadparwaiz1/cmp_luasnip' }
  use { "rafamadriz/friendly-snippets" }
  use { 'L3MON4D3/LuaSnip', requires = { 'rafamadriz/friendly-snippets' }, after = 'cmp_luasnip' }

  -- Git
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = "require('talama.plugins.git.signs')",
    event = "BufRead"
  }
  use { 'sindrets/diffview.nvim', config = "require('talama.plugins.git.diffview')" }
  use { 'akinsho/git-conflict.nvim', config = "require('talama.plugins.git.conflict')" }
  use { 'kdheepak/lazygit.nvim' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

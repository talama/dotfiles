local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then 
  return 
end

-- List of server to be installed automatically
local servers = {
  'sumneko_lua',
  'cssls',
  'html',
  'tsserver',
  'pyright',
  'jsonls',
  'yamlls'
}

-- LSP installer options
local opts = {
   -- ensure_installed is not needed as automatic_installation is enabled
   -- then any lsp server you setup by lspconfig is going to get installed automatically!

   -- ensure_installed = { "lua" },
   automatic_installation = true,

   ui = {
      icons = {
         server_installed = " ",
         server_pending = " ",
         server_uninstalled = '✗'
      },
      keymaps = {
         toggle_server_expand = "<CR>",
         install_server = "i",
         update_server = "u",
         check_server_version = "c",
         update_all_servers = "U",
         check_outdated_servers = "C",
         uninstall_server = "X",
      },
   },

   max_concurrent_installers = 10, 
}

lsp_installer.setup(opts);

local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
  return
end

for _, server in pairs(servers) do
  opts = {
    on_attach = require('user.lsp.handlers').on_attach,
    capabilities = require('user.lsp.handlers').capabilities,
  }

  if server == 'sumneko_lua' then
    local sumneko_opts = require 'user.lsp.settings.sumneko_lua'
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  lspconfig[server].setup(opts)
end

-- Setup installer and install required servers
local lsp_installer_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not lsp_installer_ok then
  return
end

lsp_installer.setup {
  -- List of severs to automatically install if they are not alredy intalled
  ensure_installed = { "bashls", "cssls", "eslint", "html", "jsonls", "sumneko_lua", "tailwindcss", "tsserver" },
  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed
  automatic_installation = true,

  ui = {
    -- The border to use for the UI window.
    border = "rounded",
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}

-- LSP configuration
local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

-- Border
_G.border = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }

-- Docs Window
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

-- set border in lspconfig
-- https://neovim.discourse.group/t/lspinfo-window-border/1566/5
local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts

win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = 'rounded'
  return opts
end

local function on_attach(client, bufnr)
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_nvim_lsp_ok then
  capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

lspconfig.tsserver.setup {
  capabilities = require('talama.lsp.servers.tsserver').capabilities,
  handlers = handlers,
  on_attach = require('talama.lsp.servers.tsserver').on_attach,
  settings = require('talama.lsp.servers.tsserver').settings
}

lspconfig.eslint.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = require('talama.lsp.servers.eslint').on_attach,
  settings = require('talama.lsp.servers.eslint').settings,
}

lspconfig.jsonls.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  settings = require('talama.lsp.servers.jsonls').settings,
}

lspconfig.sumneko_lua.setup {
  handlers = handlers,
  on_attach = on_attach,
  settings = require('talama.lsp.servers.sumneko_lua').settings,
}

for _, server in ipairs { "bashls", "cssls", "graphql", "html", } do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
  }
end

-- Diagnostic icons
local signs = {
  Error = ' ',
  Warn = ' ',
  Hint = '',
  Info = ' ',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

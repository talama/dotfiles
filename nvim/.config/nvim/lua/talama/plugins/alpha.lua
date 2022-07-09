local present, alpha = pcall(require, "alpha")
if not present then
  return
end

local dashboard = require("alpha.themes.dashboard")

local header = {
  [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
  [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
  [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
  [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
  [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
  [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
}

dashboard.section.header.type = "text";
dashboard.section.header.val = header;
dashboard.section.header.opts = {
  position = "center",
}

dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", "<cmd>ene <BAR> startinsert <CR>"),
  dashboard.button("f", "  Find file", "<cmd>Telescope find_files <CR>"),
  dashboard.button("t", "  Find text", "<cmd>Telescope live_grep <CR>"),
  dashboard.button("r", "  Recently used files", "<cmd>Telescope oldfiles <CR>"),
  dashboard.button("h", "  Find help", "<cmd>Telescope help_tags <CR>"),
  dashboard.button("K", "  Find Keymaps", "<cmd>Telescope keymaps<CR>"),
  dashboard.button("C", " Find commands", "<cmd>Telescope commands<CR>"),
  dashboard.button("u", "  Update Plugins", "<cmd>PackerSync<CR>"),
  dashboard.button("c", "  Configuration", "<cmd>e lua/talama/plugins.lua<CR>"),
  dashboard.button("q", "  Quit Neovim", "<cmd>qa<CR>"),
}

local function footer()
  local plugins = #vim.tbl_keys(packer_plugins)
  local v = vim.version()
  local dat = os.date(" %d-%m-%Y   %H:%M:%S")
  -- local platform = vim.fn.has "win32" == 1 and "" or ""
  return string.format(" %d.%d.%d   %d plugins  %s", v.major, v.minor, v.patch, plugins, dat)
end

dashboard.section.footer.val = {
  footer()
}
dashboard.section.footer.opts = {
  position = "center",
}

local section = {
  header = dashboard.section.header,
  hi_top_section = hi_top_section,
  hi_bottom_section = hi_bottom_section,
  buttons = dashboard.section.buttons,
  footer = dashboard.section.footer,
}

local opts = {
  layout = {
    { type = "padding", val = 1 },
    section.header,
    { type = "padding", val = 1 },
    section.buttons,
    { type = "padding", val = 1 },
    section.footer,
  },
  opts = {
    margin = 5
  },
}
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(opts)

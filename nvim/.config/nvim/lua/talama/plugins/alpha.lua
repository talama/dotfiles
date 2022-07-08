local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")

-- More fonts see http://www.patorjk.com/software/taag

dashboard.section.header.val = {
  [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
  [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
  [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
  [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
  [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
  [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
}

dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", "<cmd>ene <BAR> startinsert <CR>"),
  dashboard.button("f", "  Find file", "<cmd>Telescope find_files <CR>"),
  dashboard.button("t", "  Find text", "<cmd>Telescope live_grep <CR>"),
  dashboard.button("r", "  Recently used files", "<cmd>Telescope oldfiles <CR>"),
  dashboard.button("h", "  Find help", "<cmd>Telescope help_tags <CR>"),
  dashboard.button("K", "  Find Keymaps", "<cmd>Telescope keymaps<CR>"),
  dashboard.button("C", "גּ  Find commands", "<cmd>Telescope commands<CR>"),
  dashboard.button("s", "  Find colorscheme", "<cmd>Telescope colorscheme<CR>"),
  dashboard.button("c", "  Configuration", "<cmd>e ~/AppData/Local/nvim/init.lua<CR>"),
  dashboard.button("q", "  Quit Neovim", "<cmd>qa<CR>"),
}

local function footer()
  -- NOTE: requires the fortune-mod package to work
  -- local handle = io.popen("fortune")
  -- local fortune = handle:read("*a")
  -- handle:close()
  -- return fortune
  return "Neovim Alpha Dashboard"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)

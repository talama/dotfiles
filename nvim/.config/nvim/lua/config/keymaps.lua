-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Buffer
map("n", "<TAB>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<S-TAB>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<C-n>", "<cmd>enew<cr>", { desc = "New buffer" })

-- Don't yank on delete char
map({ "n", "x" }, "x", '"_x')
map({ "n", "x" }, "X", '"_X')

-- Yank to clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Yank to clipboard" })

-- Delete to void register
map("n", "<leader>d", '"_d', { desc = "Delete to void register" })
map("x", "<leader>d", '"_d', { desc = "Delete to void register" })

-- Better paste
map("v", "p", '"_dP')

-- Movement
map("i", "<C-b>", "<ESC>^i", { desc = "Move to beginning of line" })
map("n", "<C-b>", "^", { desc = "Move to beginning of line" })
map({ "n", "i" }, "<C-e>", "<END>", { desc = "Move to end line" })
map("i", "<C-h>", "<Left>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-l>", "<Right>")

-- Comments
vim.keymap.set("x", "<leader>/", "gc", { remap = true })
vim.keymap.set("n", "<leader>/", "gcc", { remap = true })

-- vscode
if vim.g.vscode then
  -- Better window navigation
  -- map({ "n", "x" }, "<C-j>", "<cmd> call VSCodeNotify('workbench.action.navigateDown') <CR>")
  -- map({ "n", "x" }, "<C-k>", "<cmd> call VSCodeNotify('workbench.action.navigateUp') <CR>")
  -- map({ "n", "x" }, "<C-h>", "<cmd> call VSCodeNotify('workbench.action.navigateLeft') <CR>")
  -- map({ "n", "x" }, "<C-l>", "<cmd> call VSCodeNotify('workbench.action.navigateRight') <CR>")

  -- Window resize
  map({ "n", "x" }, "<C-Left>", "<cmd> call VSCodeNotify('workbench.action.decreaseViewWidth') <CR>")
  map({ "n", "x" }, "<C-Right>", "<cmd> call VSCodeNotify('workbench.action.increaseViewWidth') <CR>")
  map({ "n", "x" }, "<C-Up>", "<cmd> call VSCodeNotify('workbench.action.increaseViewHeight') <CR>")
  map({ "n", "x" }, "<C-Down>", "<cmd> call VSCodeNotify('workbench.action.decreaseViewHeight') <CR>")
end

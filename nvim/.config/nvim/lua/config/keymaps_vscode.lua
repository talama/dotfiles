local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

local opts = { silent = true }

-- Sidebars
map("n", "<leader>e", "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>", opts)
map("n", "<leader>a", "<cmd>lua require('vscode').action('workbench.action.toggleActivityBarVisibility')<CR>")

-- Windows
map("n", "<leader>wD", "<cmd>lua require('vscode').action('workbench.action.closeEditorsInGroup')<CR>", opts) -- close all windows in editor group
map("n", "<leader>wj", "<cmd>lua require('vscode').action('workbench.action.toggleFullScreen')<CR>", opts)    -- merge editor groups
map("n", "<leader>wx", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>", opts)
map("n", "<leader>wm", "<cmd>lua require('vscode').action('workbench.action.toggleMaximizeEditorGroup')<CR>", opts)
map("n", "<leader>wM", "<cmd>lua require('vscode').action('workbench.action.maximizeEditorHideSidebar')<CR>", opts)
map("n", "<leader>we", "<cmd>lua require('vscode').action('workbench.action.evenEditorWidths')<CR>", opts)

-- LSP
-- definitions
map("n", "<leader>gd", "<cmd>lua require('vscode').action('editor.action.revealDefinition')<CR>", opts)
map("n", "<leader>pd", "<cmd>lua require('vscode').action('editor.action.peekDefinition')<CR>", opts)
-- declarations
map("n", "<leader>gD", "<cmd>lua require('vscode').action('editor.action.revealDeclaration')<CR>", opts)
map("n", "<leader>pD", "<cmd>lua require('vscode').action('editor.action.peekDeclaration')<CR>", opts)
--type definitions
map("n", "<leader>gy", "<cmd>lua require('vscode').action('editor.action.goToTypeDefinition')<CR>", opts)
map("n", "<leader>py", "<cmd>lua require('vscode').action('editor.action.peekTypeDefinition')<CR>", opts)
-- implementation
map("n", "<leader>gi", "<cmd>lua require('vscode').action('editor.action.goToImplementation')<CR>", opts)
map("n", "<leader>pi", "<cmd>lua require('vscode').action('editor.action.peekImplementation')<CR>", opts)
-- references
map("n", "<leader>gr", "<cmd>lua require('vscode').action('editor.action.goToReferences')<CR>", opts)
map("n", "<leader>gR", "<cmd>lua require('vscode').action('references-view.findReferences')<CR>", opts)
-- help
map("n", "<leader>gh", "<cmd>lua require('vscode').action('editor.action.triggerParameterHints')<CR>", opts)
-- symbol
map("n", "<leader>gs", "<cmd>lua require('vscode').action('workbench.action.gotoSymbol')<CR>", opts)

-- code action
map("n", "<leader>ca", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>", opts)

-- format
map("n", "<leader>cf", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>", opts)

-- SEARCH
map("n", "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>", opts)
map("n", "<leader>fw", "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>", opts)

-- Zen Mode
map("n", "<leader>z", "<cmd>lua require('vscode').action('workbench.action.toggleZenMode')<CR>", opts)

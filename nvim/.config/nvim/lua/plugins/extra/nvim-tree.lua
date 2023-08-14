local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "x", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
  vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
  vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
  vim.keymap.set("n", "a", api.fs.create, opts("Create"))
  vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
  vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
  vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
  vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
  vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
  vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
  vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
  vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
  vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
end

return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup {
      on_attach = on_attach,
      -- disables netrw completely
      disable_netrw = true,
      -- hijack netrw window on startup
      hijack_netrw = true,
      -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
      open_on_tab = false,
      -- hijack the cursor in the tree to put it at the start of the filename
      hijack_cursor = true,
      -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
      update_cwd = true,
      -- opens in place of the unnamed buffer if it's empty
      hijack_unnamed_buffer_when_opening = false,
      --false by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree
      respect_buf_cwd = true,
      -- show lsp diagnostics in the signcolumn
      diagnostics = {
        enable = false,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_markers = {
          enable = false,
          icons = {
            corner = "└ ",
            edge = "│ ",
            none = "  ",
          },
        },
        icons = {
          glyphs = {
            git = {
              unstaged = "",
              staged = "",
              unmerged = "",
              renamed = "➜",
              untracked = "",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
      update_focused_file = {
        -- enables the feature
        enable = true,
        -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
        -- only relevant when `update_focused_file.enable` is true
        update_cwd = true,
        -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
        -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
        ignore_list = {},
      },
      view = {
        -- width of the window, can be either a number (columns) or a string in `%`
        width = 30,
        hide_root_folder = false,
        -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
        side = "left",
        number = false,
        relativenumber = false,
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
    }
  end
}

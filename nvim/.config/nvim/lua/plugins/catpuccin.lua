return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  opts = {
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    background = {
      -- :h background
      light = "latte",
      dark = "macchiato",
    },
    transparent_background = false,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    -- Global highlight groups
    custom_highlights = function(colors)
      return {
        ["@variable"] = { fg = colors.text, style = {} },
        ["@property"] = { fg = colors.teal, style = {} },
        ["@method.call"] = { fg = colors.blue },
        ["@type"] = { fg = colors.yellow },
        ["@lsp.mod.readonly"] = { fg = colors.yellow },
        ["@lsp.type.parameter"] = { fg = colors.teal },
      }
    end,
    integrations = {
      alpha = true,
      cmp = true,
      gitsigns = true,
      illuminate = true,
      indent_blankline = { enabled = true },
      lsp_trouble = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      navic = { enabled = true },
      neotest = true,
      noice = true,
      notify = true,
      neotree = true,
      semantic_tokens = true,
      telescope = true,
      treesitter = true,
      which_key = true,
    },
  },
}

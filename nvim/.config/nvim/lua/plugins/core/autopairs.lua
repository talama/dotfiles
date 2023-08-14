return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  opts = {
    check_ts = true,   -- Treesitter integration
    disable_filetype = { "TelescopePrompt" },
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      java = false,
    },
    disabled_filetype = { "TelescopePrompt", "vim" },
    fast_wrap = {},
  }
}

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
   modes = {
      search = {
        enabled = true,
      },
      char = {
        jump_labels = true,
      }
    }
  },
  keys = {
    { "z",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "L",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  },
}

-- fzf-native
return {
  "telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },

  keys = {
    -- disable the keymap to grep files
    { "<leader>/", false },
    { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
  },
}

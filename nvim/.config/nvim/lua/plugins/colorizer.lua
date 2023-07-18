return {
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        css = "true",
        css_fn = "true",
        hsl_fn = "true",
        rgb_fn = "true",
        tailwind = "true",
        sass = { enable = "true", parsers = { "css" } },
        filetypes = {
          "css",
          "javascript",
          "html",
        },
        virtualtext = "■",
        mode = { "background" },
      },
    },
  },
}

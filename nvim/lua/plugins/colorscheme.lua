-- Colorscheme configuration
return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    theme = "dragon",
    overrides = function(colors)
      return {
        LineNr = { fg = colors.palette.dragonBlack6 },
        LineNrAbove = { fg = colors.palette.dragonBlack6 },
        LineNrBelow = { fg = colors.palette.dragonBlack6 },
      }
    end,
  },
  config = function(_, opts)
    require("kanagawa").setup(opts)
    vim.cmd([[colorscheme kanagawa-dragon]])
  end,
}

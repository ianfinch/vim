vim.g.mapleader = "," -- Set leader key before Lazy
 
require("custom.lazy")
require("custom.keymap")
require("custom.settings")

require("custom.nvim-tree")
require("custom.nvim-treesitter")
require("custom.oil")
require("custom.lualine")
require("custom.git")
require("colorizer").setup()

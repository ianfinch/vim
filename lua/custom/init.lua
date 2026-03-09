vim.g.mapleader = "," -- Set leader key before Lazy
 
-- My own plugins
require("custom.lazy")
require("custom.settings")
require("custom.buffers")
require("custom.npm")
require("custom.projects")
require("custom.recent-files")
require("custom.sessions")
require("custom.snippets")
require("custom.web-server")

-- Configure third-party plugins
require("custom.nvim-tree")
require("custom.nvim-treesitter")
require("custom.oil")
require("custom.lualine")
require("custom.git")
require("custom.colouriser")
require("custom.test")

-- Do keymapping last, so we can override plugins if needed
require("custom.keymap")

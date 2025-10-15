-- Start off by using the standard vim settings
vim.opt.compatible = false

-- Under default settings, making changes and then opening a new file will
-- display E37: No write since last change (add ! to override)
--
-- With :set hidden, opening a new file when the current buffer has unsaved
-- changes causes files to be hidden instead of closed (the unsaved changes can
-- still be accessed by typing :ls and then :b[N])
vim.opt.hidden = true

-- Turn off swap files (can't remember ever making use of them)
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.wb = false

-- Use wildmenu for command completion
vim.opt.wildmode = "full"
vim.opt.wildmenu = true

-- Make vim quieter
vim.opt.visualbell = true

-- Highlight search matches
vim.opt.hlsearch = true

-- Line numbering
vim.opt.number = true

-- Highlight the current cursor line
vim.opt.cursorline = true

-- Use spaces for tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Use ftplugins
vim.cmd("filetype plugin on")

-- Colour scheme
vim.cmd("colorscheme iantheme")

-- Turn on folding
vim.opt.fillchars = {
	vert = "┃",
	fold = "-"
}

-- Function to create well formated text for the folds
function _G.custom_fold_text()

    local label = vim.fn.getline(vim.v.foldstart)
    local line_count = vim.v.foldend - vim.v.foldstart + 1

    return "⚡" .. label .. " (" .. line_count .. " lines) "
end

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.custom_fold_text()"

vim.g.markdown_folding = 1

-- Honour modelines
vim.opt.modeline = true
vim.opt.modelines = 5

-- Use netrw in tree view
vim.g.netrw_liststyle=3

-- Make vertical splits open on the right of the current one
vim.opt.splitright = true

-- Disable providers we don't use
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Disable Buffergator taking over all the keymap
vim.g.buffergator_suppress_keymaps = 1

--
-- Autocmds ... if this grows, may think about moving to their own file
--

-- Recognise Nginx config files
vim.cmd([[
au BufRead,BufNewFile nginx.conf set ft=nginx
]])

-- Enable TODO highlighting in all files
vim.cmd([[
autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|TBC\|TBD\|FIXME\|CHANGED\|BUG\|HACK\)')
autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|IDEA\)')
]])

-- Go back to where we were last time we quit
vim.api.nvim_create_autocmd({"BufReadPost"}, {
	pattern = "*",
	command = 'silent! normal! g`"zv'
})

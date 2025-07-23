-- vim: foldmethod=marker

-- A bunch of basic settings {{{

-- Start off by using the standard vim settings
vim.opt.compatible = false

-- Under default settings, making changes and then opening a new file will
-- display E37: No write since last change (add ! to override)
--
-- With :set hidden, opening a new file when the current buffer has unsaved
-- changes causes files to be hidden instead of closed (the unsaved changes can
-- still be accessed by typing :ls and then :b[N])
vim.opt.hidden = true

-- Make single quote jump to marked character instead of marked line.  We will
-- want to do this much more often - and single quote is easier to hit than
-- backtick.
vim.keymap.set("n", "'", "`", { noremap = true })
vim.keymap.set("n", "`", "'", { noremap = true })

-- Use comma as leader character - more hittable and more standard than
-- backslash
vim.g.mapleader = ","

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
vim.keymap.set("", "<Leader>/", ":nohlsearch<CR>")

-- Line numbering
vim.opt.number = true

-- Highlight the current cursor line
vim.opt.cursorline = true

-- }}}

-- Use spaces for tabs {{{
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
-- }}}

-- Use ftplugins {{{
vim.cmd("filetype plugin on")
-- }}}

-- Autocomplete {{{
vim.opt.omnifunc = "syntaxcomplete#Complete"
vim.opt.omnifunc = "javascriptcomplete#CompleteJS"
-- }}}

-- Colour scheme {{{
vim.cmd("colorscheme iantheme")
-- }}}

-- Syntax highlighting {{{
vim.cmd([[
syntax on
au FileType javascript call JavaScriptFold()
au BufRead,BufNewFile nginx.conf set ft=nginx
]])
-- }}}

-- Enable TODO highlighting in all files {{{
vim.cmd([[
autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|TBC\|TBD\|FIXME\|CHANGED\|BUG\|HACK\)')
autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|IDEA\)')
]])
-- }}}

-- Go back to where we were last time we quit {{{
vim.api.nvim_create_autocmd({"BufReadPost"}, {
	pattern = "*",
	command = 'silent! normal! g`"zv'
})
-- }}}

-- Airline setup {{{
vim.g.airline_theme = 'guzo'
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#fnamemod'] = ':t'
vim.g['airline#extensions#tabline#show_close_button'] = 0
vim.g['airline#extensions#tabline#tabs_label'] = ''
vim.g['airline#extensions#tabline#buffers_label'] = ''
vim.g['airline#extensions#tabline#show_tab_count'] = 0
vim.g['airline#extensions#tabline#show_buffers'] = 0
vim.g['airline#extensions#tabline#tab_min_count'] = 2
vim.g['airline#extensions#tabline#show_splits'] = 0 -- disables buffer name on right of the tabline
vim.g['airline#extensions#tabline#show_tab_nr'] = 0
vim.opt.laststatus = 2
vim.opt.showmode = false
-- }}}

-- Set up rainbow brackets {{{
-- TBD
-- if exists("*rainbow_parentheses#toggle")
--     au VimEnter * RainbowParenthesesToggle
--     au Syntax * RainbowParenthesesLoadRound
--     au Syntax * RainbowParenthesesLoadSquare
--     au Syntax * RainbowParenthesesLoadBraces
-- endif
-- }}}

-- Turn on folding {{{
vim.opt.fillchars = {
	vert = "|",
	fold = "-"
}
-- TBD
-- function! NeatFoldText()
--    let foldchar = matchstr(&fillchars, 'fold:\zs.')
--    if getline(v:foldstart) == '/**'
--       let foldLabel = substitute(getline(v:foldstart + 1), '^ *\*', '//', '')
--    else
--       let foldLabel = getline(v:foldstart)
--    endif
--    let lineCount = v:foldend - v:foldstart + 1
--    return repeat('+', v:foldlevel) . '-- ' . foldLabel . " (" . lineCount . " lines) "
-- endfunction
vim.opt.foldmethod = "syntax"
vim.opt.foldtext = "NeatFoldText()"

vim.g.markdown_folding = 1
-- }}}

-- Honour modelines {{{
vim.opt.modeline = true
vim.opt.modelines = 5
-- }}}

-- Ultisnips {{{
vim.g.UltiSnipsExpandTrigger="<Leader>e"
vim.g.UltiSnipsJumpForwardTrigger="<Leader>e"
vim.g.UltiSnipsJumpBackwardTrigger="<Leader>E"
-- }}}

-- Session save and load shortcuts {{{

-- TBD
-- function GuzoLoadSession ()
--    let sessionList = map(split(glob($HOME . '/.vim-sessions/*')), 'fnamemodify(v:val, ":t")')
--    let numberedList = map(copy(sessionList), 'string(v:key+1).": ".v:val')
--    let session = inputlist(numberedList)
--    echo ' '
--    echo ' '
--    if 0 < session && session <= len(sessionList)
--       execute 'source ' . $HOME . '/.vim-sessions/' . sessionList[session-1]
--    else
--       echo 'Invalid selection: ' . session
--       echo ' '
--       call input('Hit any key to continue ... ')
--    endif
-- endfunction

-- TBD
-- function GuzoSaveSession ()
--    if !isdirectory($HOME . '/.vim-sessions')
--        call mkdir($HOME . '/.vim-sessions')
--    endif
--    let session = input('Name for session: ')
--    if (empty(session))
--       echo 'Session not saved (no session name supplied)'
--    else
--       execute 'mksession! ' . $HOME . '/.vim-sessions/' . session
--       echo 'Saved session: ' . session
--    endif
-- endfunction

-- :map <Leader>ls :call GuzoLoadSession()<CR>
-- :map <Leader>ss :call GuzoSaveSession()<CR>

-- }}}

-- Recent files list {{{

vim.keymap.set("", "<Leader>r", ":MRU<CR>")

-- }}}

-- Keys for easier use of files, buffers and tabs {{{

-- Use Leader-f to open NERDTree
vim.keymap.set("", "<Leader>f", ":NERDTree<CR>")

-- Use netrw in tree view
vim.g.netrw_liststyle=3

-- Use tab / shift-tab to go through the tabs
vim.keymap.set("n", "<TAB>", ":tabnext<CR>", { noremap = true })
vim.keymap.set("n", "<S-TAB>", ":tabprevious<CR>", { noremap = true })
vim.keymap.set("", "<Leader><TAB>", ":tabprevious<CR>")

-- Don't use buffergator's default keymap
vim.g.buffergator_suppress_keymaps = 1

-- Keep buffergator open after buffer selection
vim.g.buffergator_autodismiss_on_select = 0

-- Buffergator commands to open / close the buffer display
vim.keymap.set("", "<Leader>b", ":BuffergatorOpen<CR>")
vim.keymap.set("", "<Leader>B", ":BuffergatorClose<CR>")

-- Shortcuts to open / close tabs
vim.keymap.set("", "<Leader>to", ":tabnew<CR>")
vim.keymap.set("", "<Leader>tc", ":tabclose<CR>")

-- Shortcuts for horizontal and vertical split
vim.opt.splitright = true
vim.keymap.set("", "<Leader>|", ":vsplit<CR>")
vim.keymap.set("", "<Leader>-", ":split<CR>")
-- }}}

-- Additional key mappings {{{

-- Trigger make
vim.keymap.set("", "<Leader>m", ":make!<CR>")

-- Open git commit browser
vim.keymap.set("", "<Leader>g", ":GV<CR>")

-- Set a key for colorizer (to avoid conflict with tab keys)
vim.keymap.set("n", "<Leader>c", "<Plug>Colorizer")

-- Open a terminal
vim.keymap.set("", "<Leader>tt", ":term<CR>")
-- }}}

-- Automatically find unit tests {{{

-- TBD
-- function OpenUnitTestFile ()
--    let srcFile = expand('%:p')
-- 
--    let testFile = substitute(srcFile, '/src/\([^/]*/[^/]*\)\.clj', '/test/\1_test.clj', '')
-- 
--    execute "vsplit" testFile
-- endfunction
-- 
-- :map <Leader>u :call OpenUnitTestFile()<CR>

-- }}}

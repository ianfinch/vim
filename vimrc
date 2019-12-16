" vim: foldmethod=marker

" A bunch of basic settings {{{

" A lot of this came from http://items.sjbach.com/319/configuring-vim-right
" and https://github.com/skwp/dotfiles/blob/master/vimrc

" Start off by using the standard vim settings
set nocompatible

" Under default settings, making changes and then opening a new file will
" display E37: No write since last change (add ! to override)
"
" With :set hidden, opening a new file when the current buffer has unsaved
" changes causes files to be hidden instead of closed (the unsaved changes can
" still be accessed by typing :ls and then :b[N])
set hidden

" Make single quote jump to marked character instead of marked line.  We will
" want to do this much more often - and single quote is easier to hit than
" backtick.
nnoremap ' `
nnoremap ` '

" Use comma as leader character - more hittable and more standard than
" backslash
let mapleader = ","

" Turn off swap files (can't remember ever making use of them)
set noswapfile
set nobackup
set nowb

" Use wildmenu for command completion
set wildmode=full
set wildmenu  

" Make vim quieter
set visualbell

" Highlight search matches
set hlsearch
:map <Leader>/ :nohlsearch<CR>

" Line numbering
set number

" }}}

" Use spaces for tabs {{{
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
" }}}

" Load in Pathogen {{{
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
" }}}

" Use ftplugins {{{
filetype plugin on
" }}}

" Colour scheme {{{
set background=dark
colorscheme solarized
" }}}

" Syntax highlighting {{{
syntax on
au FileType javascript call JavaScriptFold()
au BufRead,BufNewFile nginx.conf set ft=nginx
" }}}

" Enable TODO highlighting in all files {{{
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|TBC\|TBD\|FIXME\|CHANGED\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|IDEA\)')
  endif
endif
" }}}

" Go back to where we were last time we quit {{{
autocmd BufReadPost *
   \ if line("'\"") > 1 && line("'\"") <= line("$") |
   \   exe "normal! g`\"" |
   \ endif
" }}}

" Airline setup {{{
let g:airline_theme = 'guzo'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
set laststatus=2
set noshowmode
" }}}

" Set up rainbow brackets {{{
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" }}}

" Turn on folding {{{
set fillchars=vert:\|,fold:-
function! NeatFoldText()
   let foldchar = matchstr(&fillchars, 'fold:\zs.')
   if getline(v:foldstart) == '/**'
      let foldLabel = substitute(getline(v:foldstart + 1), '^ *\*', '//', '')
   else
      let foldLabel = getline(v:foldstart)
   endif
   let lineCount = v:foldend - v:foldstart + 1
   return repeat('+', v:foldlevel) . '-- ' . foldLabel . " (" . lineCount . " lines) "
endfunction
set foldmethod=syntax
set foldtext=NeatFoldText()

let g:markdown_folding = 1
" }}}

" Set up vimwiki {{{
let g:vimwiki_list = [{'path': '/Users/ian/Dropbox/vimwiki/',
                     \ 'path_html': '/Users/ian/Dropbox/Wiki/',
                     \ 'template_path': '/Users/ian/Dropbox/vimwiki_templates/',
                     \ 'template_default': 'template',
                     \ 'template_ext': '.html',
                     \ 'auto_export': 1}]
" }}}

" Honour modelines {{{
set modeline
set modelines=5
" }}}

" Ultisnips {{{
let g:UltiSnipsExpandTrigger="<Leader>e"
let g:UltiSnipsJumpForwardTrigger="<Leader>e"
let g:UltiSnipsJumpBackwardTrigger="<Leader>E"
" }}}

" Session save and load shortcuts {{{

function GuzoLoadSession ()
   let sessionList = map(split(glob($HOME . '/.vim-sessions/*')), 'fnamemodify(v:val, ":t")')
   let numberedList = map(copy(sessionList), 'string(v:key+1).": ".v:val')
   let session = inputlist(numberedList)
   echo ' '
   echo ' '
   if 0 < session && session <= len(sessionList)
      execute 'source ' . $HOME . '/.vim-sessions/' . sessionList[session-1]
   else
      echo 'Invalid selection: ' . session
      echo ' '
      call input('Hit any key to continue ... ')
   endif
endfunction

function GuzoSaveSession ()
   if !isdirectory($HOME . '/.vim-sessions')
       call mkdir($HOME . '/.vim-sessions')
   endif
   let session = input('Name for session: ')
   if (empty(session))
      echo 'Session not saved (no session name supplied)'
   else
      execute 'mksession! ' . $HOME . '/.vim-sessions/' . session
      echo 'Saved session: ' . session
   endif
endfunction

:map <Leader>ss :call GuzoLoadSession()<CR>
:map <Leader>s+ :call GuzoSaveSession()<CR>

" }}}

" Keys for easier use of files, buffers and tabs {{{

" Use Leader-f to open (vinegar enhanced) netrw
:map <Leader>f :edit .<CR>

" Use netrw in tree view
let g:netrw_liststyle=3

" Use tab / shift-tab to go through the tabs
nnoremap <TAB> :tabnext<CR>
nnoremap <S-TAB> :tabprevious<CR>
:map <Leader><TAB> :tabprevious<CR>

" Don't use buffergator's default keymap
let g:buffergator_suppress_keymaps = 1

" Buffergator commands to open / close the buffer display
:map <Leader>b :BuffergatorOpen<CR>
:map <Leader>B :BuffergatorClose<CR>

" Shortcuts to open / close tabs
:map <Leader>to :tabnew<CR>
:map <Leader>tc :tabclose<CR>

" Shortcuts for horizontal and vertical split
set splitright
:map <Leader>\| :vsplit<CR>
:map <Leader>- :split<CR>
" }}}

" Additional key mappings {{{

" Trigger make
:map <Leader>m :make!<CR>

" Set a key for colorizer (to avoid conflict with tab keys)
nmap <unique> <Leader>c <Plug>Colorizer
" }}}

" Automatically find unit tests {{{

function OpenUnitTestFile ()
   let srcFile = expand('%:p')

   let testFile = substitute(srcFile, '/src/\([^/]*/[^/]*\)\.clj', '/test/\1_test.clj', '')

   execute "vsplit" testFile
endfunction

:map <Leader>u :call OpenUnitTestFile()<CR>

" }}}

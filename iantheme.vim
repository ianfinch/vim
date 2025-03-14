" vim: foldmethod=marker
"
" Name: iantheme.vim
" Author: Ian Finch
" Version: 0.1

let colors_name = "iantheme"

hi Comment ctermfg=2 guifg=#ffffff

" Constants {{{
hi Constant term=underline ctermfg=30 guifg=#339999
hi link Boolean   Constant
hi link Character Constant
hi link Number    Constant
hi link Float     Number
hi String ctermfg=82 guifg=#66FF00
hi Regexp ctermfg=30 guifg=#44B4CC
" }}}

" Diffs {{{
hi DiffAdd    term=bold ctermbg=4 guibg=DarkBlue
hi DiffChange term=bold ctermbg=5 guibg=DarkMagenta
hi DiffDelete term=bold ctermfg=12 ctermbg=6 gui=bold guifg=Blue guibg=DarkCyan
hi DiffText   term=reverse cterm=bold ctermbg=9 gui=bold guibg=Red
hi link diffAdded   String
hi link diffLine    PreProc
hi link diffRemoved Statement
hi link diffSubname Comment
" }}}

" Folding {{{
hi Folded term=standout ctermfg=195 ctermbg=18 guifg=#aaddee guibg=#110077
hi link FoldColumn Folded
" }}}

" Identifiers {{{
hi Identifier term=underline ctermfg=220 guifg=#FFCC00
hi link Function Identifier
" }}}

" Message highlights {{{
hi ErrorMsg   term=standout ctermbg=1                            guibg=Red
hi Error      term=reverse  ctermfg=15  ctermbg=1  guifg=White   guibg=Red
hi Normal                   ctermfg=253 ctermbg=16 guifg=#EEEEEE guibg=Black
hi Todo       term=standout ctermfg=0   ctermbg=11 guifg=Blue    guibg=Yellow
hi WarningMsg term=standout ctermfg=9              guifg=Red
" }}}

" Pre-processors {{{
hi PreProc term=underline ctermfg=123 guifg=#AAFFFF
hi link Include   PreProc
hi link Define    PreProc
hi link Macro     PreProc
hi link PreCondit PreProc
" }}}

" Special characters {{{
hi Special term=bold ctermfg=40 guifg=#33AA00
hi link Tag            Special
hi link SpecialChar    Special
hi link Delimiter      Special
hi link SpecialComment Special
hi link Debug          Special
" }}}

" Spellcheck {{{
hi SpellBad   term=reverse   ctermbg=1 gui=undercurl guisp=Red
hi SpellCap   term=reverse   ctermbg=4 gui=undercurl guisp=Blue
hi SpellLocal term=underline ctermbg=6 gui=undercurl guisp=Cyan
hi SpellRare  term=reverse   ctermbg=5 gui=undercurl guisp=Magenta
" }}}

" Statements {{{
hi Statement term=bold ctermfg=208 guifg=#FF6600
hi link Conditional Statement
hi link Repeat      Statement
hi link Label       Statement
hi link Operator    Statement
hi link Keyword     Statement
hi link Exception   Statement
" }}}

" Status line {{{
hi StatusLineNC     term=reverse                 ctermfg=0 ctermbg=248 guifg=#444444 guibg=#aaaaaa
hi StatusLineTermNC term=reverse                 ctermfg=0 ctermbg=121 guifg=bg guibg=LightGreen
hi StatusLineTerm   term=bold,reverse cterm=bold ctermfg=0 ctermbg=121 gui=bold guifg=bg guibg=LightGreen
hi StatusLine       term=bold,reverse cterm=bold ctermfg=0 ctermbg=15  gui=bold guifg=Black guibg=#aabbee
" }}}

" Tab bar {{{
hi TabLineFill term=reverse   cterm=underline ctermfg=247 ctermbg=241 gui=underline guifg=#bbbbbb guibg=#808080
hi TabLineSel  term=bold      cterm=bold      ctermfg=15  ctermbg=0   gui=bold      guifg=White guibg=Black
hi TabLine     term=underline cterm=underline ctermfg=247 ctermbg=232 gui=underline guifg=#bbbbbb guibg=#333333
" }}}

" Types {{{
hi Type term=underline ctermfg=186 guifg=#AAAA77
hi link StorageClass Type
hi link Structure    Type
hi link Typedef      Type
" }}}

" Vim's stuff {{{
hi ColorColumn   term=reverse ctermbg=1 guibg=DarkRed
hi Conceal       ctermfg=7 ctermbg=242 guifg=LightGrey guibg=DarkGrey
hi CursorColumn  term=reverse ctermbg=242 guibg=#333333
hi CursorLineNr  term=bold cterm=underline ctermfg=11 gui=bold guifg=Yellow
hi CursorLine    term=underline cterm=underline guibg=#333333
hi Cursor        ctermfg=0 ctermbg=15 guifg=Black guibg=White
hi Ignore        ctermfg=0 guifg=bg
hi IncSearch     term=reverse cterm=reverse ctermfg=15 ctermbg=0 gui=reverse guifg=White guibg=Black
hi LineNr        term=underline ctermfg=15 guifg=#DDEEFF
hi MatchParen    term=reverse ctermbg=20 guibg=#1100AA
hi ModeMsg       term=bold cterm=bold gui=bold
hi MoreMsg       term=bold ctermfg=10 gui=bold guifg=#00AA00
hi NonText       term=bold ctermfg=8 gui=bold guifg=#404040
hi PmenuSbar     ctermbg=248 guibg=Grey
hi PmenuSel      cterm=bold ctermfg=15 ctermbg=105 gui=bold guifg=White guibg=#5555ff
hi PmenuThumb    ctermbg=15 guibg=White
hi Pmenu         cterm=bold ctermfg=15 ctermbg=20 gui=bold guifg=White guibg=#000099
hi Search        term=reverse ctermbg=235 guibg=#555555
hi SignColumn    term=standout ctermfg=14 ctermbg=242 guifg=Cyan guibg=Grey
hi SpecialKey    term=bold ctermfg=8 guifg=#404040
hi Title         term=bold ctermfg=13 gui=bold guifg=Magenta
hi ToolbarButton cterm=bold ctermfg=0 ctermbg=7 gui=bold guifg=Black guibg=LightGrey
hi ToolbarLine   term=underline ctermbg=242 guibg=Grey50
hi Underlined    term=underline cterm=underline ctermfg=81 gui=underline guifg=#80a0ff
hi VertSplit     term=reverse cterm=reverse gui=reverse
hi VisualNOS     ctermbg=235 guibg=#444444
hi Visual        term=reverse ctermbg=241 guibg=#555577
hi link Directory   Identifier
hi link EndOfBuffer NonText
hi link Question     MoreMsg
hi link QuickFixLine Search
" }}}

" Javascript {{{
hi link javascriptNull         Constant
hi link javascriptNumber       Number
hi link javascriptRegexpString Regexp
" }}}

" Ruby / Rails {{{
hi rubyMethod ctermfg=228 guifg=#DDE93D
hi rubyNumber ctermfg=190 guifg=#CCFF33
hi link rubyAccess          rubyMethod
hi link rubyAttribute       rubyMethod
hi link rubyDefine          Keyword
hi link rubyEval            rubyMethod
hi link rubyException       rubyMethod
hi link rubyInclude         rubyMethod
hi link rubyRegexp          Regexp
hi link rubyRegexpDelimiter rubyRegexp
hi link rubyStringDelimiter rubyString
hi link rubySymbol          Constant

hi railsUserClass ctermfg=7 gui=italic guifg=#AAAAAA
hi railsUserMethod ctermfg=45 gui=italic guifg=#AACCFF
hi link railsMethod PreProc
" }}}

" Not sure what these are {{{
"WildMenu       xxx term=standout cterm=bold ctermfg=0 ctermbg=11 gui=bold guifg=Black guibg=#ffff00
" }}}

" vim: foldmethod=marker
"
" Name: iantheme.vim
" Author: Ian Finch
" Version: 0.1

let colors_name = "iantheme"

hi Comment ctermfg=207

" Constants {{{
hi Constant term=underline ctermfg=30
hi link Boolean   Constant
hi link Character Constant
hi link Number    Constant
hi link Float     Number
hi String ctermfg=82
hi Regexp ctermfg=30
" }}}

" Diffs {{{
hi DiffAdd    term=bold    ctermbg=4
hi DiffChange term=bold    ctermbg=5
hi DiffDelete term=bold    ctermbg=6 ctermfg=12
hi DiffText   term=reverse ctermbg=9
hi link diffAdded   String
hi link diffLine    PreProc
hi link diffRemoved Statement
hi link diffSubname Comment
" }}}

" Folding {{{
hi Folded term=standout ctermfg=195 ctermbg=18
hi link FoldColumn Folded
" }}}

" Identifiers {{{
hi Identifier term=underline ctermfg=220
hi link Function Identifier
" }}}

" Message highlights {{{
hi ErrorMsg   term=standout             ctermbg=1
hi Error      term=reverse  ctermfg=15  ctermbg=1
hi Normal                   ctermfg=253 ctermbg=16
hi Todo       term=standout ctermfg=0   ctermbg=11
hi WarningMsg term=standout ctermfg=9
" }}}

" Pre-processors {{{
hi PreProc term=underline ctermfg=123
hi link Include   PreProc
hi link Define    PreProc
hi link Macro     PreProc
hi link PreCondit PreProc
" }}}

" Special characters {{{
hi Special term=bold ctermfg=40
hi link Tag            Special
hi link SpecialChar    Special
hi link Delimiter      Special
hi link SpecialComment Special
hi link Debug          Special
" }}}

" Spellcheck {{{
hi SpellBad   term=reverse   ctermbg=1
hi SpellCap   term=reverse   ctermbg=4
hi SpellLocal term=underline ctermbg=6
hi SpellRare  term=reverse   ctermbg=5
" }}}

" Statements {{{
hi Statement term=bold ctermfg=208
hi link Conditional Statement
hi link Repeat      Statement
hi link Label       Statement
hi link Operator    Statement
hi link Keyword     Statement
hi link Exception   Statement
" }}}

" Status line {{{
hi StatusLineNC     term=reverse                 ctermfg=0 ctermbg=248
hi StatusLineTermNC term=reverse                 ctermfg=0 ctermbg=121
hi StatusLineTerm   term=bold,reverse ctermfg=0 ctermbg=121
hi StatusLine       term=bold,reverse ctermfg=0 ctermbg=15
" }}}

" Tab bar {{{
hi TabLineFill term=reverse   ctermfg=247 ctermbg=241
hi TabLineSel  term=bold           ctermfg=15  ctermbg=0
hi TabLine     term=underline ctermfg=247 ctermbg=232
" }}}

" Types {{{
hi Type term=underline ctermfg=186
hi link StorageClass Type
hi link Structure    Type
hi link Typedef      Type
" }}}

" Vim's stuff {{{
hi ColorColumn   term=reverse ctermbg=1
hi Conceal       ctermfg=7 ctermbg=242
hi CursorColumn  term=reverse ctermbg=242
hi CursorLineNr  term=bold ctermfg=11
hi CursorLine    term=underline
hi Cursor        ctermfg=0 ctermbg=15
hi Ignore        ctermfg=0
hi IncSearch     term=reverse ctermfg=15 ctermbg=0
hi LineNr        term=underline ctermfg=15
hi MatchParen    term=reverse ctermbg=20
hi ModeMsg       term=bold
hi MoreMsg       term=bold ctermfg=10
hi NonText       term=bold ctermfg=8
hi PmenuSbar     ctermbg=248
hi PmenuSel      ctermfg=15 ctermbg=105
hi PmenuThumb    ctermbg=15
hi Pmenu         ctermfg=15 ctermbg=20
hi Search        term=reverse ctermbg=235
hi SignColumn    term=standout ctermfg=14 ctermbg=242
hi SpecialKey    term=bold ctermfg=8
hi Title         term=bold ctermfg=13
hi ToolbarButton ctermfg=0 ctermbg=7
hi ToolbarLine   term=underline ctermbg=242
hi Underlined    term=underline ctermfg=81
hi VertSplit     term=reverse
hi VisualNOS     ctermbg=235
hi Visual        term=reverse ctermbg=241
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
hi rubyMethod ctermfg=228
hi rubyNumber ctermfg=190
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

hi railsUserClass ctermfg=7
hi railsUserMethod ctermfg=45
hi link railsMethod PreProc
" }}}

" Not sure what these are {{{
"WildMenu       xxx term=standout ctermfg=0 ctermbg=11
" }}}

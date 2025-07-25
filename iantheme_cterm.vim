" vim: foldmethod=marker
"
" Name: iantheme.vim
" Author: Ian Finch
" Version: 0.1

let colors_name = "iantheme"

hi Comment ctermfg=207

" Constants {{{
hi Constant ctermfg=30
hi link Boolean   Constant
hi link Character Constant
hi link Number    Constant
hi link Float     Number
hi String ctermfg=82
hi Regexp ctermfg=30
" }}}

" Diffs {{{
hi DiffAdd       ctermbg=4
hi DiffChange    ctermbg=5
hi DiffDelete    ctermbg=6 ctermfg=12
hi DiffText   ctermbg=9
hi link diffAdded   String
hi link diffLine    PreProc
hi link diffRemoved Statement
hi link diffSubname Comment
" }}}

" Folding {{{
hi Folded ctermfg=195 ctermbg=18
hi link FoldColumn Folded
" }}}

" Identifiers {{{
hi Identifier ctermfg=220
hi link Function Identifier
" }}}

" Text colours {{{
hi ErrorMsg                ctermbg=1
hi Error       ctermfg=15  ctermbg=1
hi Normal      ctermfg=253 ctermbg=16
hi NormalFloat ctermfg=253 ctermbg=23
hi Todo        ctermfg=0   ctermbg=11
hi WarningMsg  ctermfg=9
" }}}

" Pre-processors {{{
hi PreProc ctermfg=123
hi link Include   PreProc
hi link Define    PreProc
hi link Macro     PreProc
hi link PreCondit PreProc
" }}}

" Special characters {{{
hi Special ctermfg=40
hi link Tag            Special
hi link SpecialChar    Special
hi link Delimiter      Special
hi link SpecialComment Special
hi link Debug          Special
" }}}

" Spellcheck {{{
hi SpellBad     ctermbg=1
hi SpellCap     ctermbg=4
hi SpellLocal ctermbg=6
hi SpellRare    ctermbg=5
" }}}

" Statements {{{
hi Statement ctermfg=208
hi link Conditional Statement
hi link Repeat      Statement
hi link Label       Statement
hi link Operator    Statement
hi link Keyword     Statement
hi link Exception   Statement
" }}}

" Status line {{{
hi StatusLineNC     cterm=NONE ctermfg=0 ctermbg=248
hi StatusLineTermNC cterm=NONE ctermfg=0 ctermbg=121
hi StatusLineTerm   cterm=NONE ctermfg=0  ctermbg=121
hi StatusLine       cterm=NONE ctermfg=15 ctermbg=53
" }}}

" Tab bar {{{
hi TabLineFill cterm=NONE ctermfg=15 ctermbg=53
hi TabLineSel  cterm=NONE ctermfg=15 ctermbg=55
hi TabLine     cterm=NONE ctermfg=15 ctermbg=53
" }}}

" Types {{{
hi Type ctermfg=186
hi link StorageClass Type
hi link Structure    Type
hi link Typedef      Type
" }}}

" Vim's stuff {{{
hi ColorColumn   ctermbg=1
hi Conceal       ctermfg=7 ctermbg=242
hi CursorColumn  ctermbg=242
hi CursorLineNr  cterm=NONE ctermbg=234
hi CursorLine    cterm=NONE ctermbg=234
hi Cursor        ctermfg=0 ctermbg=15
hi Ignore        ctermfg=0
hi IncSearch     ctermfg=15 ctermbg=0
hi LineNr        ctermfg=15
hi MatchParen    ctermbg=20
hi ModeMsg       ctermfg=15
hi MoreMsg       ctermfg=10
hi NonText       ctermfg=8
hi PmenuSbar     ctermbg=248
hi PmenuSel      ctermfg=15 ctermbg=105
hi PmenuThumb    ctermbg=15
hi Pmenu         ctermfg=15 ctermbg=20
hi Search        ctermbg=235
hi SignColumn    ctermfg=14 ctermbg=242
hi SpecialKey    ctermfg=8
hi Title         ctermfg=13
hi ToolbarButton ctermfg=0 ctermbg=7
hi ToolbarLine   ctermbg=242
hi Underlined    ctermfg=81
hi VertSplit     ctermfg=15
hi VisualNOS     ctermbg=235
hi Visual        ctermbg=241
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
"WildMenu       xxx ctermfg=0 ctermbg=11
" }}}

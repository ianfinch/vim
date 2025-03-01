" Normal mode
let s:N1 = [ '#ffffff' , '#5f00af' , 15 , 55  ]
let s:N2 = [ '#ffffff' , '#875fd7' , 15 , 98  ]
let s:N3 = [ '#ffffff' , '#800080' , 15 , 53 ]

" Insert mode
let s:I1 = [ '#ffffff' , '#005fff' , 15 , 33  ]
let s:I2 = [ '#ffffff' , '#00afff' , 15 , 39  ]
let s:I3 = [ '#ffffff' , '#0000ff' , 15 , 20 ]

" Visual mode
let s:V1 = [ '#121212' , '#ff5f00' , 233 , 202 ]
let s:V2 = [ '#121212' , '#ffaf00' , 233 , 214 ]
let s:V3 = [ '#ffffff' , '#875f00' , 233 , 166 ]

" Replace mode
let s:R1 = [ '#ffffff' , '#ff0000' , 15 , 196 ]
let s:R2 = [ '#ffffff' , '#ff5f5f' , 15 , 203 ]
let s:R3 = [ '#ffffff' , '#870000' , 15 , 210 ]

" Inactive mode
let s:IN = [ '#a0a0a0' , '#5f5f5f' , 15  , 240 ]

let g:airline#themes#guzo#palette = {
    \ 'normal':   airline#themes#generate_color_map(s:N1, s:N2, s:N3),
    \ 'insert':   airline#themes#generate_color_map(s:I1, s:I2, s:I3),
    \ 'visual':   airline#themes#generate_color_map(s:V1, s:V2, s:V3),
    \ 'replace':  airline#themes#generate_color_map(s:R1, s:R2, s:R3),
    \ 'inactive': airline#themes#generate_color_map(s:IN, s:IN, s:IN)
    \ }

" CtrlP
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif

let s:CP1 =  [ '#ffffff' , '#5f00af' , 15 , 55 ]
let s:CP2 =  [ '#ffffff' , '#875fd7' , 15 , 98 ]
let s:CP3 =  [ '#5f00af' , '#ffffff' , 55 , 15 ]

let g:airline#themes#guzo#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(s:CP1, s:CP2, s:CP3)

" Tabline
"let g:airline#themes#guzo#palette.tabline = {
"      \ 'airline_tab':     [ '#ffffff' , '#5f00af' ,  15  , 25  , '' ],
"      \ 'airline_tabsel':  [ '#ffffff' , '#875fd7' ,  233 , 39  , '' ],
"      \ 'airline_tabtype': [ '#ffffff' , '#875fd7' ,  15  , 25  , '' ],
"      \ 'airline_tabfill': [ '#ffffff' , '#005f87' ,  15  , 17  , '' ],
"      \ 'airline_tabmod':  [ '#ffffff' , '#ff5f5f' ,  15  , 33  , '' ]
"      \ }

" Tabline
let g:airline#themes#guzo#palette.tabline = {
      \ 'airline_tablabel':     [ '#ffffff' , '#00ff00' ,  15  , 25  , '' ],
      \ 'airline_tab':          [ '#ffffff' , '#00ff00' ,  15  , 25  , '' ],
      \ 'airline_tabsel':       [ '#ffffff' , '#00ff00' ,  233 , 39  , '' ],
      \ 'airline_tabtype':      [ '#ffffff' , '#00ff00' ,  15  , 25  , '' ],
      \ 'airline_tabfill':      [ '#ffffff' , '#00ff00' ,  15  , 17  , '' ],
      \ 'airline_tabmod':       [ '#ffffff' , '#00ff00' ,  15  , 33  , '' ],
      \ 'airline_tabmod_unsel': [ '#ffffff' , '#00ff00' ,  15  , 33  , '' ],
      \ 'airline_tabhid':       [ '#ffffff' , '#00ff00' ,  15  , 33  , '' ]
      \ }

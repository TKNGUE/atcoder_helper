" ========================================
" Author: author_name <mail>
" Contributers:
" License: 
" Version:
" ========================================
"
if exists('g:loaded_atcoder_helper')
    finish
endif
let g:loaded_atcoder_helper = 1


let s:save_cpo = &cpo
set cpo&vim


command! AtCoder -nargs=1 call atcoder_helper#init(<args>)


let &cpo = s:save_cpo
unlet s:save_cpo

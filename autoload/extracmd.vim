" =============================================================================
" Filename: autoload/extracmd.vim
" Author: itchyny
" License: MIT License
" Last Change: 2015/02/21 22:51:57.
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! extracmd#set(...) abort
  let [flag, name, command] = (len(a:000) == 2 ? [''] : []) + a:000
  execute 'cnoreabbrev <expr>' flag name
        \ 'getcmdtype() ==# '':'' && getcmdline() =~# ''^[:[:blank:]]*' . name . ''''
        \ '?' string(command) ':' string(name)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

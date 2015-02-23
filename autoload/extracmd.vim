" =============================================================================
" Filename: autoload/extracmd.vim
" Author: itchyny
" License: MIT License
" Last Change: 2015/02/23 16:49:35.
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! extracmd#set(...) abort
  let [flag, name, command] = (len(a:000) == 2 ? [''] : []) + a:000
  let pre = substitute(name, '\[.*', '', '')
  let post = matchstr(name, '\[\zs.\{-}\ze\]')
  for i in range(len(post) + 1)
    let name = pre . (i ? post[:i-1] : '')
    execute 'cnoreabbrev <expr>' flag name
          \ 'getcmdtype() ==# '':'' && getcmdline() =~# ''^[:[:blank:]]*' . name . ''''
          \ '?' string(command) ':' string(name)
  endfor
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

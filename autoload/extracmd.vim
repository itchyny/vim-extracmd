" =============================================================================
" Filename: autoload/extracmd.vim
" Author: itchyny
" License: MIT License
" Last Change: 2015/02/23 21:03:52.
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! extracmd#set(...) abort
  let [flag, name, command] = (len(a:000) == 2 ? [''] : []) + a:000
  let pre = substitute(name, '\[.*', '', '')
  let post = matchstr(name, '\[\zs.\{-}\ze\]')
  let rest = matchstr(name, '^.\{-}\]\zs.*', '', '')
  for i in range(len(post) + 1)
    let name = pre . (i ? post[:i-1] : '') . rest
    if rest =~# '\[.\{-}\]'
      call extracmd#set(flag, name, command)
    else
      execute 'cnoreabbrev <expr>' flag name
            \ 'getcmdtype() ==# '':'' && getcmdline() =~# ''^[:[:blank:]]*' . name . ''''
            \ '?' string(command) ':' string(name)
    endif
  endfor
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

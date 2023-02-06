let s:next      = exists('g:insautocomplete_direction') ? g:insautocomplete_direction : "\<C-N>"
let s:prev      = s:next =~# "\<C-N>" ? "\<C-P>" : "\<C-N>"
let s:separator = (has("win64") || has("win32") || has("win16")) ? '[/\\]' : '[/]'
let s:timer_id  = 0
let s:patterns  = {
\ 'path'   : '\v^%(%(\.{1,2}|\~|\w+)' ..s:separator ..'|' ..s:separator ..'{1,2}\w+).*',
\ 'omni'   : exists('g:insautocomplete_omni_pattern') ? g:insautocomplete_omni_pattern : '\v\k+%(\.|\-\>|\:\:|'')$',
\ 'user'   : exists('g:insautocomplete_user_pattern') ? g:insautocomplete_omni_pattern : '\v\k+%(\.|\-\>|\:\:|'')$',
\ 'keyword': '\v\k+$',
\}

function! s:text_before_cursor() abort
  return matchstr(getline('.'), '\S\+\%' ..virtcol('.') ..'v') ..v:char
endfunction

function! s:insert(char) abort
  let timer_id = timer_start(0, feedkeys(a:char, 'n'))
endfunction

function! s:trigger() abort
  let text = fnameescape(s:text_before_cursor())
  " 1. File paths
  if (text =~# get(s:patterns, 'path', ''))
    if !empty(globpath(fnamemodify(text, ":p:h"), fnamemodify(text, ":p:t") .."*"))
      return "\<C-X>\<C-F>"
    endif
  endif
  " 2. Omni completion
  if !empty(&omnifunc)
    if (text =~# get(s:patterns, 'omni', ''))
      return "\<C-X>\<C-O>"
    endif
  endif
  " 3. User completion
  if !empty(&completefunc)
    if (text =~# get(s:patterns, 'user', ''))
      return "\<C-X>\<C-U>"
    endif
  endif
  " 4. Keywords
  if (text =~# get(s:patterns, 'keyword', ''))
    return "\<C-N>"
  endif
  return ''
endfunction

function! insautocomplete#previous(key='') abort
  if pumvisible()
    call s:insert(s:prev)
  else
    call s:insert(a:key)
  endif
  return ''
endfunction

function! insautocomplete#next(key='') abort
  if pumvisible()
    call s:insert(s:next)
  else
    call s:insert(a:key)
  endif
  return ''
endfunction

function! insautocomplete#manual_or_next(key='') abort
  if pumvisible()
    call s:insert(s:next)
  elseif s:text_before_cursor() =~? '^\s*$'
    call s:insert(a:key)
  else
    call s:insert(s:trigger())
  endif
  return ''
endfunction

function! insautocomplete#confirm(key='') abort
  if pumvisible()
    call s:insert("\<C-Y>")
  else
    call s:insert(a:key)
  endif
  return ''
endfunction

function! insautocomplete#abort(key='') abort
  if pumvisible()
    call s:insert("\<C-E>")
  else
    call s:insert(a:key)
  endif
  return ''
endfunction

function! insautocomplete#automatic() abort
  if !pumvisible()
    call s:insert(s:trigger())
  endif
  return ''
endfunction
